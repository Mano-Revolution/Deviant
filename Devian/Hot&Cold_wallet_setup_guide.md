## Preperation

1. Get a VPS from a provider like DigitalOcean, Vultr, Linode, etc. 
   - Recommended VPS size at least 1gb RAM, unbuntu 16.04    


## Cold Wallet Setup Part 1

1. Open your wallet on your desktop.
2. Go to recieve tap and create new address
3. Make sure you have a transaction of exactly 5000 DEV in your desktop cold wallet.
    * You can collect coins to an address and send 5000 DEV to another address in your same wallet
4. Go to the "Tools" -> "Debug console"
5. Run the following command: `masternode genkey`
6. You should see a long key that looks like:
```
3HaYBVUCYjEMeeH1Y4sBGLALQZE1Yc1K64xiqgX37tGBDQL8Xg
```  

7. This is your `private key`, keep it safe, do not share with anyone.



## VPS Setup

1. Log into your VPS   
2. Copy/paste these commands into the VPS and hit enter: (One Box At A Time)
```
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
```
```
 cd /var
  sudo touch swap.img
  sudo chmod 600 swap.img
  sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
  sudo mkswap /var/swap.img
  sudo swapon /var/swap.img
  sudo free
  sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab

```
```
  sudo apt-get install -y ufw
  sudo ufw allow ssh/tcp
  sudo ufw limit ssh/tcp
  sudo ufw logging on
  sudo ufw enable
  sudo ufw status
  sudo ufw allow 22618/tcp
```
```
cd /home
```
```
wget https://github.com/Deviantcoin/Wallet/raw/master/Deviantcoin\ \(Linux\)/Deviantd
```
```
chmod 750 Deviantd
```
```
./Deviantd
```
you can see error message

>Error: To use Deviantd, you must set a rpcpassword in the configuration file:
>/root/.Deviant/Deviant.conf
>It is recommended you use the following random password:
>rpcuser=Deviantrpc
>rpcpassword=4AxX1hHnCGVrf3K3qbJLXtUpTn9bFaXXKo4vWms4Mqzn
>(you do not need to remember this password)
>The username and password MUST NOT be the same.
>If the file does not exist, create it with owner-readable-only file permissions.
>It is also recommended to set alertnotify so you are notified of problems;
>for example: alertnotify=echo %s | mail -s "Deviant Alert" admin@foo.com

its -ok
Go on

```
nano ~/.Deviant/Deviant.conf
```

copy and paste with your info!

```
daemon=1
rpcuser=anythingyouwant
rpcpassword=anythingyouwant
rpcallowip=127.0.0.1
port=7118
masternode=1
server=1
listen=1
masternodeaddr=VPS_IP_AADRESS:7118
masternodeprivkey=PRIVATE_KEY
```

CTRL X to save it. Y for yes, then ENTER.

last command
```
./Deviantd -daemon
```
Done

## Cold Wallet Setup Part 2 

1. Go to your window wallet   
2. Go to "Tools" -> "Debug console"
3. Run the following command: `masternode outputs`
4. You should see output like the following if you have a transaction with exactly 5000 DEV:
```
{
    "12345678xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx": "0"
}
```
5. The value on the left is your `txid` and the right is the `vout`
6. Go to masternode tap -> My masternode
7. Click Create
8. Fill the information
```
allias: any name
address: VPS_IP:7118
privekey: mnprivatekey
txhash: txid
output index: vout (0 or 1)

Click update
Click start

Done
```
Check your ip is listed on http://explorer.deviantcoin.io:3001/masternode 


