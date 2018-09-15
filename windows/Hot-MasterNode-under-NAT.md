# Hot MasterNode under NAT
## When a user can follow this guide
1. The user get a static ip address from his provider 
2. The user want to run a Masternode at home, no matter that a VPS can assure higher online time

## Prerequisites
1. The [preparation steps](https://github.com/ScaMar/Deviant-Masternode/blob/master/common/Preparation-steps-for-MN.md) are fullfilled (this guide inherit same name convention)
2. Knowledge about port forward rules on own router (or how to enable UPnP support)
3. The workstation/home server must have static lan ip address

## Check your public ip
To check own public ip, a user can just open this link in a browser: [http://ident.me](http://ident.me)<br />
Own IP will appear in the browser.<br />
From now on, it will be referenced by {YOUR PUBLIC IP} .

## Enable UPnP
If own router supports UPnP, use it. If not, a forward rule (external port:22618 <-> internal:22618) must be created on the router.
Settings -> Options -> Network -> Set the flag on "Map port using UPnP" (UPnP is disabled in defaults settings)<br />

Settings Options | Network tab
---------------- | -----------
![GUI-options](/images/GUI-options.png) | ![network](/images/network.png)

<br />
## Check lan address
Search own lan address in the preferred way (network options or ipconfig cmd utility).
Lan address must be static in network options of your lan interface, or, dhcp server (usually it runs on the router) must be configure to assign always same ip to the mac address of workstation/home server lan interface.
From now on it will be referenced by {YOUR LAN IP}

## Fill file deviant.conf
Open file deviant.conf<br />
![open deviant.conf](/images/edit-local-conf.png)
Add such parameters:<br />
```masternode=1
masternodeaddr={YOUR PUBLIC IP}:22618
masternodeprivkey={MN PRIV KEY}
externalip={YOUR PUBLIC IP}
bind={YOUR LAN IP}
rpcallowip=127.0.0.1
daemon=1
server=1
listen=1
rpcport=22619
rpcbind=127.0.0.1
shrinkdebuglog=1
logtimestamps=1
```
## Fill file masternode.conf
Open file deviant.conf<br />
![open masternode.conf](/images/edit-masternode-conf.png)
Add such line:<br />
```{MN ALIAS} {YOUR PUBLIC IP}:22618 {MN PRIV KEY} {MN TX-iD} {TX-ID IDX}```
Restart your wallet to apply new conf files

## Start alias




