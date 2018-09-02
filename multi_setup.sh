#!/bin/bash
TMP_FOLDER=$(mktemp -d)
CONFIGFOLDER=$HOME/.DeviantCore
CONFIG_FILE='deviant.conf'
COIN_DAEMON='deviantd'
COIN_CLI='deviant-cli'
COIN_PATH='/usr/local/bin/'
COIN_NAME='Deviant'
COIN_TGZ='https://github.com/Deviantcoin/Wallet/raw/master/dev-3.0.0.1-linux-x86_64.zip'
COIN_ZIP=$(echo $COIN_TGZ | awk -F'/' '{print $NF}')
COIN_PORT=22618
RPC_PORT=22617


BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'

## ToDo: Add a check to verify if daemon is running

function check_user() {
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}$0 must be run as root.${NC}"
   exit 1
fi
}

function it_exists() {
if [[ -d $CONFIGFOLDER$IP_SELECT ]]; then
  echo -e "It seems a $COIN_NAME instance is already installed in $CONFIGFOLDER$IP_SELECT"
  echo -e "Type y to scratch it (be carefull, if you are staking on this VPS, also your wallet will be erased)"
  echo -e "Type n to exit"
read -e ANSWER
case $ANSWER in
     y)      
          kill -9 $(pidof deviantd)
          rm -rf $CONFIGFOLDER$IP_SELECT
          ;;
     n)      
          exit 0
          ;;
     *)
          it_exists
          ;; 
esac
fi
}

function download_node() {
  echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
  cd $TMP_FOLDER >/dev/null 2>&1
  wget -q $COIN_TGZ
  if [[ $? -ne 0 ]]; then
   echo -e 'Error downloading node. Please contact support'
   exit 1
  fi
  if [[ -f $COIN_PATH$COIN_DAEMON ]]; then
  unzip -j $COIN_ZIP *$COIN_DAEMON
  MD5SUMOLD=$(md5sum $COIN_PATH$COIN_DAEMON | awk '{print $1}')
  MD5SUMNEW=$(md5sum $COIN_DAEMON | awk '{print $1}')
  pidof $COIN_DAEMON
  RC=$?
   if [[ "$MD5SUMOLD" -ne "$MD5SUMNEW" && "$RC" -eq 0 ]]; then
     echo -e 'Those daemon(s) are about to die'
     echo -e $(ps axo cmd:100 | grep $COIN_DAEMON | grep -v grep)
     echo -e 'If no check is implemented, take care of their restart'
     killall $COIN_DAEMON
   fi
  fi
  unzip -o -j $COIN_ZIP *$COIN_DAEMON *$COIN_CLI -d $COIN_PATH >/dev/null 2>&1
  chmod +x $COIN_PATH$COIN_DAEMON $COIN_PATH$COIN_CLI
  cd ~ >/dev/null 2>&1
  rm -rf $TMP_FOLDER >/dev/null 2>&1
  clear
}

function custom_exe() {
  echo '#!/bin/bash' > $COIN_PATH$COIN_CLI$IP_SELECT.sh
  echo "$COIN_PATH$COIN_CLI -conf=$CONFIGFOLDER$IP_SELECT/$CONFIG_FILE -datadir=$CONFIGFOLDER$IP_SELECT \$@" >> $COIN_PATH$COIN_CLI$IP_SELECT.sh
  chmod 755 $COIN_PATH$COIN_CLI$IP_SELECT.sh
  echo '#!/bin/bash' > $COIN_PATH$COIN_DAEMON$IP_SELECT.sh
  echo "$COIN_PATH$COIN_DAEMON -conf=$CONFIGFOLDER$IP_SELECT/$CONFIG_FILE -datadir=$CONFIGFOLDER$IP_SELECT \$@" >> $COIN_PATH$COIN_DAEMON$IP_SELECT.sh
  chmod 755 $COIN_PATH$COIN_DAEMON$IP_SELECT.sh
  clear
}

function configure_systemd() {
  cat << EOF > /etc/systemd/system/$COIN_NAME$IP_SELECT.service
[Unit]
Description=$COIN_NAME$IP_SELECT service
After=network.target
[Service]
User=root
Group=root
Type=forking
ExecStart=$COIN_PATH$COIN_DAEMON -daemon -conf=$CONFIGFOLDER$IP_SELECT/$CONFIG_FILE -datadir=$CONFIGFOLDER$IP_SELECT
ExecStop=-$COIN_PATH$COIN_CLI -conf=$CONFIGFOLDER$IP_SELECT/$CONFIG_FILE -datadir=$CONFIGFOLDER$IP_SELECT stop
Restart=always
PrivateTmp=true
TimeoutStopSec=60s
TimeoutStartSec=10s
StartLimitInterval=120s
StartLimitBurst=5
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable $COIN_NAME$IP_SELECT.service >/dev/null 2>&1
systemctl start $COIN_NAME$IP_SELECT.service
sleep 3
netstat -napt | grep LISTEN | grep $NODEIP | grep $COIN_DAEMON
 if [[ $? -ne 0 ]]; then
   declare -a ERRSTATUS
   ERRSTATUS=TRUE
 fi
}

function check_swap() {
SWAPSIZE=$(cat /proc/meminfo | grep SwapTotal | awk '{print $2}')
FREESPACE=$(df / | tail -1 | awk '{print $4}')
if [ $SWAPSIZE -lt 400000 ]
  then if [ $FREESPACE -gt 6000000 ]
    then dd if=/dev/zero of=/swapfile bs=250MB count=16 
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile none swap sw 0 0' >> /etc/fstab
    else echo 'Swap seems smaller than recommended. It cannot be increased because of lack of space'
    fi
fi  
}

function create_config() {
  mkdir $CONFIGFOLDER$IP_SELECT >/dev/null 2>&1
  RPCUSER=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
  RPCPASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
  let RPC_PORT=$RPC_PORT-$IP_SELECT
  cat << EOF > $CONFIGFOLDER$IP_SELECT/$CONFIG_FILE
rpcuser=$RPCUSER
rpcpassword=$RPCPASSWORD
rpcport=$RPC_PORT
rpcallowip=127.0.0.1
listen=0
server=1
daemon=1
port=$COIN_PORT
EOF
}

function create_key() {
  echo -e "${YELLOW}Enter your ${RED}$COIN_NAME Masternode GEN Key${NC}"
  echo -e "${YELLOW}Press enter to let the script generate one${NC}"
  read -e COINKEY
  if [[ -z "$COINKEY" ]]; then
  $COIN_PATH$COIN_DAEMON$IP_SELECT.sh -daemon
  sleep 30
  if [ -z "$(ps axo cmd:100 | grep $COIN_DAEMON)" ]; then
   echo -e "${RED}$COIN_NAME server couldn not start. Check /var/log/syslog for errors.{$NC}"
   exit 1
  fi
  COINKEY=$($COIN_PATH$COIN_CLI$IP_SELECT.sh masternode genkey)
  if [ "$?" -gt "0" ];
    then
    echo -e "${RED}Wallet not fully loaded. Let us wait and try again to generate the GEN Key${NC}"
    sleep 30
    COINKEY=$($COIN_PATH$COIN_CLI$IP_SELECT.sh masternode genkey)
  fi
  $COIN_PATH$COIN_CLI$IP_SELECT.sh stop
fi
clear
}

function update_config() {
  sed -i 's/daemon=1/daemon=0/' $CONFIGFOLDER$IP_SELECT/$CONFIG_FILE
  cat << EOF >> $CONFIGFOLDER$IP_SELECT/$CONFIG_FILE
logintimestamps=1
maxconnections=256
bind=$NODEIP
masternode=1
externalip=$NODEIP:$COIN_PORT
masternodeprivkey=$COINKEY
#Addnodes: clear comment if dnsseeds fails. Check output in debug.log file
#addnode=209.97.139.2
#addnode=45.35.64.39
#addnode=138.197.146.236
#addnode=167.99.234.81
#addnode=206.189.155.48
#addnode=209.97.131.147
#addnode=209.97.131.20
#addnode=209.97.139.20
#addnode=219.74.243.91:22618
#addnode=109.10.53.168:22618
#addnode=178.239.54.249:22618
EOF
}


function get_ip() {
  declare -a NODE_IPS
  for ips in $(ip a | grep inet | awk '{print $2}' | cut -f1 -d "/")
  do
    NODE_IPS+=($(curl --interface $ips --connect-timeout 4 -s4 icanhazip.com))
  done

  if [ ${#NODE_IPS[@]} -gt 1 ]
    then
      echo -e "${GREEN}More than one IP. Please type 0 to use the first IP, 1 for the second and so on...${NC}"
      INDEX=0
      for ip in "${NODE_IPS[@]}"
      do
        echo ${INDEX} $ip
        let INDEX=${INDEX}+1
      done
      read -e choose_ip
      IP_SELECT=$choose_ip
      NODEIP=${NODE_IPS[$choose_ip]}
  else
    NODEIP=${NODE_IPS[0]}
    IP_SELECT=1
  fi
}



function important_information() {
 echo
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${PURPLE}multiple vps setup${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${GREEN}$COIN_NAME Masternode is up and running listening on port${NC}${PURPLE}$COIN_PORT${NC}."
 echo -e "${GREEN}Configuration file is:${NC}${RED}$CONFIGFOLDER$IP_SELECT/$CONFIG_FILE${NC}"
 echo -e "${GREEN}VPS_IP:${NC}${GREEN}$NODEIP:$COIN_PORT${NC}"
 echo -e "${GREEN}MASTERNODE GENKEY is:${NC}${PURPLE}$COINKEY${NC}"
 echo -e "${BLUE}================================================================================================================================"
 echo -e "${CYAN}Temp${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${CYAN}Ensure Node is fully SYNCED with BLOCKCHAIN (with cli or with custom cli command).${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${PURPLE}Server start (with cli or with custom cli command).${NC}"
 echo -e "${GREEN}deviantd -datadir=$CONFIGFOLDER$IP_SELECT -daemon${NC}"
 echo -e "${GREEN}$COIN_DAEMON$IP_SELECT.sh -daemon${NC}"
 echo -e "${PURPLE}Server start (with systemctl).${NC}"
 echo -e "${GREEN}systemctl start $COIN_NAME$IP_SELECT.service${NC}"
 echo -e "${PURPLE}Server stop.${NC}"
 echo -e "${GREEN}deviant-cli -datadir=$CONFIGFOLDER$IP_SELECT stop${NC}"
 echo -e "${GREEN}$COIN_CLI$IP_SELECT.sh stop${NC}"
 echo -e "${PURPLE}Usage Commands.${NC}"
 echo -e "${GREEN}deviant-cli -datadir=$CONFIGFOLDER$IP_SELECT masternode status${NC}"
 echo -e "${GREEN}$COIN_CLI$IP_SELECT.sh masternode status${NC}"
 echo -e "${GREEN}deviant-cli -datadir=$CONFIGFOLDER$IP_SELECT getinfo${NC}"
 echo -e "${GREEN}$COIN_CLI$IP_SELECT.sh getinfo${NC}"
 echo -e "${GREEN}deviant-cli -datadir=$CONFIGFOLDER$IP_SELECT mnsync status${NC}"
 echo -e "${GREEN}$COIN_CLI$IP_SELECT.sh mnsync status${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 if [[ "$ERRSTATUS" == "$TRUE" ]]; then
    echo -e "${RED}$COIN_NAME$IP_SELECT seems not running, please investigate. Check its status by running the following commands as root:${NC}"
    echo -e "systemctl status $COIN_NAME$IP_SELECT.service"
    echo -e "${RED}You can restart it by firing following command (as root):${NC}"
    echo -e "${GREEN}systemctl start $COIN_NAME$IP_SELECT.service${NC}"
    echo -e "${RED}Check errors by runnig following commands:${NC}"
    echo -e "${GREEN}less /var/log/syslog${NC}"
    echo -e "${GREEN}journalctl -xe${NC}"
 fi
 
 }

function setup_node() {
  check_user
  check_swap
  download_node
  get_ip
  it_exists
  create_config
  custom_exe
  create_key
  update_config
  configure_systemd
  important_information
}


##### Main #####
setup_node
