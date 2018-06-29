#/bin/bash

cd ~
echo "****************************************************************************"
echo "* Ubuntu 16.04 is the recommended opearting system for this install.       *"
echo "*                                                                          *"
echo "* This script will install and configure your Deviant Coin masternodes.    *"
echo "****************************************************************************"
echo && echo && echo
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "!                                                 !"
echo "! Make sure you double check before hitting enter !"
echo "!                                                 !"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo && echo && echo

echo "Do you want to install all needed dependencies (no if you did it before)? [y/n]"
read DOSETUP

if [[ $DOSETUP =~ "y" ]] ; then
  sudo apt-get update
  sudo apt-get -y upgrade
  sudo apt-get -y dist-upgrade
  sudo apt-get install -y nano htop git
  sudo apt-get install -y software-properties-common
  sudo apt-get install -y build-essential libtool autotools-dev pkg-config libssl-dev
  sudo apt-get install -y libboost-all-dev
  sudo apt-get install -y libevent-dev
  sudo apt-get install -y libminiupnpc-dev
  sudo apt-get install -y autoconf
  sudo apt-get install -y automake unzip
  sudo add-apt-repository  -y  ppa:bitcoin/bitcoin
  sudo apt-get update
  sudo apt-get install -y libdb4.8-dev libdb4.8++-dev

  cd /var
  sudo touch swap.img
  sudo chmod 600 swap.img
  sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
  sudo mkswap /var/swap.img
  sudo swapon /var/swap.img
  sudo free
  sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
  cd

  sudo apt-get install -y ufw
  sudo ufw allow ssh/tcp
  sudo ufw limit ssh/tcp
  sudo ufw logging on
  echo "y" | sudo ufw enable
  sudo ufw status

  mkdir -p ~/bin
  echo 'export PATH=~/bin:$PATH' > ~/.bash_aliases
  source ~/.bashrc
fi

wget "https://github.com/Deviantcoin/Wallet/raw/master/dev-3.0.0.1-linux-x86_64.tar.gz"
tar -xvzf dev-3.0.0.1-linux-x86_64.tar.gz
cd linux-static-libs
sudo mv  deviant*/* /usr/bin




echo ""
echo "Enter masternode private key for node $ALIAS"
read PRIVKEY

CONF_DIR=~/.Deviant/
mkdir $CONF_DIR
CONF_FILE=Deviant.conf
IP=$(curl -s4 icanhazip.com)
PORT=22618

echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
echo "listen=1" >> $CONF_DIR/$CONF_FILE
echo "server=1" >> $CONF_DIR/$CONF_FILE
echo "daemon=1" >> $CONF_DIR/$CONF_FILE
echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
echo "maxconnections=256" >> $CONF_DIR/$CONF_FILE
echo "masternode=1" >> $CONF_DIR/$CONF_FILE
echo "rpcport=22617" >> $CONF_DIR/$CONF_FILE
echo "" >> $CONF_DIR/$

echo "addnode=209.97.139.2"          >> $CONF_DIR/$CONF_FILE     
echo "addnode=45.35.64.39"           >> $CONF_DIR/$CONF_FILE
echo "addnode=138.197.146.236"       >> $CONF_DIR/$CONF_FILE
echo "addnode=167.99.234.81"         >> $CONF_DIR/$CONF_FILE
echo "addnode=206.189.155.48"        >> $CONF_DIR/$CONF_FILE
echo "addnode=209.97.131.147"        >> $CONF_DIR/$CONF_FILE
echo "addnode=209.97.131.20"         >> $CONF_DIR/$CONF_FILE
echo "addnode=209.97.139.20"         >> $CONF_DIR/$CONF_FILE
echo "addnode=219.74.243.91:22618"   >> $CONF_DIR/$CONF_FILE
echo "addnode=109.10.53.168:22618"   >> $CONF_DIR/$CONF_FILE
echo "addnode=178.239.54.249:22618"  >> $CONF_DIR/$CONF_FILE


echo "" >> $CONF_DIR/$CONF_FILE
echo "port=$PORT" >> $CONF_DIR/$CONF_FILE
echo "masternodeaddr=$IP:$PORT" >> $CONF_DIR/$CONF_FILE
echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE
sudo ufw allow $PORT/tcp

sudo chmod 755 /usr/bin/deviantd
sudo chmod 755 /usr/bin/deviant-cli
deviantd