Setup_guide
=============
This repository is for Masternode setup guide

* Devian masternode setup guide

# Using multiple masternode on 1 vps (VULTR)


deviant-cli getinfo
deviant-cli masternode status

deviant-cli stop

cp -r -p .DeviantCore .DeviantCore2
cp -r -p .DeviantCore .DeviantCore3

deviant 
deviantd -datadir=/root/.DeviantCore2 
deviant -datadir=/root/.DeviantCore3 

deviant-cli -datadir=/root/.DeviantCore2 getinfo
deviant-cli -datadir=/root/.DeviantCore3 getinfo

deviant-cli -datadir=/root/.DeviantCore2 masternode status
deviant-cli -datadir=/root/.DeviantCore3 masternode status
