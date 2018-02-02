## Preperation

1. Get a VPS from a provider like DigitalOcean, Vultr, Linode, etc. 
   - Recommended VPS size at least 1gb RAM    


## Cold Wallet Setup Part 1

1. Open your wallet on your desktop.
2. Go to revciev tap and create new address
3. Make sure you have a transaction of exactly 5000 DEV in your desktop cold wallet.
(You can collect coins to an address and send 5000 DEV to another address in you same wallet)
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
cd /home
```
```
wget https://github.com/Mano-Revolution/Setup_guide/blob/master/Devian/Deviantd
```
```
chmod 777 ./Deviantd
```
```
./Deviantd
```
(previous command will show message that you need to fill up Deviant.conf - its ok)
```
nano ~/.Deviant/Deviant.conf
```

copy and paste with your info!

```
daemon=1
rpcuser=randuser1234
rpcpassword=passwardofuesr
rpcallowip=127.0.0.1
port=7118
masternode=1
server=1
listen=1
masternodeaddr=VPS_IP_AADRESS:7118
masternodeprivkey=PRIVATE_KEY
```

CTRL X to save it. Y for yes, then ENTER.

Now everything is done last command
```
./Deviant -daemon
```


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
privkey: mnprivatekey
txhash: txid
output index: vout (0 or 1)

Click update
Click start

Done
```
Check your ip is listed on http://explorer.deviantcoin.io:3001/masternode 


