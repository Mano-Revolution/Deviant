#  Window wallet setup part 1

1. Make new address at recieve tap
2. Open your wallet on your desktop.

  *  Click Settings -> Options -> Wallet
  *  Check "Enable coin control features"

3. Go to the "Tools" -> "Debug console"
4. Run the following command: masternode genkey
5. You should see a long key that looks like:
'''
123fjsadfkJKLF4sBGLALQZE1Yc1K64xiqgX37t9428HJF
'''
6. This is your private key, you will need to enter the same key on your VPS’ 
Vantaur.conf file later

# Linux vps setup

1. Log into your VPS (ubuntu 16.04)
2. Copy/paste these commands into the VPS and hit enter: 
3. sudo apt-get -y update
4. sudo apt-get -y upgrade
5. sudo apt-get -y install software-properties-common
6. sudo apt-add-repository -y ppa:bitcoin/bitcoin
7. sudo apt-get install build-essential libssl-dev libboost-all-dev libqrencode-
dev pkg-config libminiupnpc-dev openssl qt5-default qttools5-dev-tools
libgmp3-dev
8. sudo apt-get install libtool autotools-dev pkg-config autoconf automake
9. sudo apt-get install libzmq3-dev libssl-dev libevent-dev libminiupnpc libgmp-dev
10. sudo apt-get -y install libdb4.8-dev
11. sudo apt-get -y install libdb4.8++-dev
12.
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
13. git clone https://github.com/MotileCoin/MotileCoin
14. cd motile
15. cd src
16. make –f makefile.unix (This will take a while 10-30mins)
17. strip motiled
18. sudo cp motiled /usr/local/bin
19. motiled
20. nano ~/.Moltile/Motile.conf (CASE SENSTIVE make sure M is CAPS)

Add	this	to	your	Vantaur.conf
```
rpcuser=PUT	ANYTHING
rpcpassword=PUT	ANY	UNIQUE	PW
rpcport=7117
server=1
listen=1
daemon=1
port=7218
masternodeaddr=YOUR VPS	IPADDRESS:PORT		for	example:		192.18.22.91:7218
masternode=1
masternodeprivkey=YOUR	PRIVKEY	that	you	generated	from	your	Windows	(Cold	Wallet)
```
Press	Ctrl-X	>	Press	Y	>	Press	[ENTER]			- to	save	your	Vantaur.Conf	file.
Stop	your motile	daemon	by	entering:
1. motiled	stop
2. Wait 30sec and input : motiled (you can see "starting")
done

# Window wallet setup part 2

1.Now	let’s	send yourself	EXACTLY	5000 MIE	to	your address
2.go	to	HELP,	DEBUG	WINDOW,	CONSOLE
3.Type:	masternode	outputs
4."txhash : output index" will show up if you sens exact 5000 coin like this
```
{
    "12345678xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx": "0"
}
```

5.Go	to	the	masternode	tab	– MY	MASTERNODES	and	click	on	Create.
7.fill it. (alias~ output index)and click ok
```
allias: any name
address: VPS_IP:7218
privekey: mnprivatekey
txhash: txhash
output index: outputindex (0 or 1)

ok
```
8. click update
9. click start


