# Deviant Masternode setup on Linux VPS
## When a user should follow this guide:
1. The user wants to setup a cold Masternode on a Linux x86_64 VPS.

## Prerequisites
1. The [preparation steps](https://github.com/ScaMar/Deviant-Masternode/blob/master/common/Preparation-steps-for-MN.md) are fullfilled (this guide inherited the same naming convention).
2. A Linux VPS is mandatory for this setup. Ubuntu 16.04 is the recommended one. Successful setup have been reported also on Ubuntu 18.04 and Centos 7
3. A client SSH for your Operating System. In this guide it will be [putty portable for win32](https://the.earth.li/~sgtatham/putty/latest/w32/putty.exe). You can use Terminal on MacOS or gnome-terminal on Linux.
3. On VPS you need `unzip` and `curl` utilities.

## Establish connection
Open your ssh client then fill it with the parameters of your VPS (ip address and ssh port, default is 22).
Establish the connection (the "Open" push button on putty), then login with your credentials.<br />

Connection parameters | Host certificate warnig | Login process
--------------------- | ----------------------- | ------------- 
![putty](/images/putty-connection.png) | ![login](/images/putty-security.png) | ![login](/images/putty-login.png)

## Check the utilities
To check unzip and curl we use:```which unzip
which curl```
The expected result is a filled line with full path.
If the output is without path, then you need to install the missing utility/utilities.

![check utilities](/images/utilities.png)

## Launch the script
To launch the script exec this commands:<br />
`wget https://raw.githubusercontent.com/ScaMar/Deviant-Masternode/master/linux/masternode_setup.sh
bash masternode_setup.sh`

![launch script](/images/launch-script.png)





