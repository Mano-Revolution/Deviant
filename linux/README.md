# Deviant Masternode setup/administration scripts for linux (x86_64)<br />
## script masternode_setup.sh<br />
This script will setup a Deviant masternode on your linux VPS.

Prerequisites:
1. you need "unzip" and "curl" utilities.
On ubuntu just type:
```apt install unzip curl```
2. you need several public ips (ipv4/ipv6/both) to run several MNs. The script will check it for you, if it find only one public ip, you can install only one MN. NAT is not supported, the IPs must be assigned to a local interface.

To execute the script you can use such commands:
1. ```wget https://raw.githubusercontent.com/ScaMar/Deviant-Masternode/master/linux/masternode_setup.sh```
2. ```bash masternode_setup.sh```

Check [Masternode Setup](https://github.com/ScaMar/Deviant-Masternode/blob/master/linux/Masternode_setup.md) guide for explanations and sample execution.
