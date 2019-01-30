Setup_guide
=============
This repository is for Deviant coin Masternode setup guide

* deviant_install.sh
    * basic setup script for masternode
* multi_setup.sh
    * multiple masternode on 1 vps (VULTR) 
    
# Usage
## masternode setup
cd /home;wget https://github.com/Mano-Revolution/Deviant/raw/master/deviant_install.sh; chmod 755  ./deviant_install.sh;./deviant_install.sh
## add masternode
cd /home;wget https://github.com/Mano-Revolution/Deviant/raw/master/multi_setup.sh; chmod 755 ./multi_setup.sh;./multi_setup.sh

## Linux qt wallet 
```
apt-get update && apt-get install -y software-properties-common && \
  apt-get install -y \
  software-properties-common \
  build-essential \
  libtool \
  autotools-dev \
  automake \
  pkg-config \
  libssl-dev \
  libevent-dev \
  bsdmainutils \
  python3 \
  libboost-system-dev \
  libboost-filesystem-dev \
  libboost-chrono-dev \
  libboost-program-options-dev \
  libboost-test-dev \
  libboost-thread-dev \
  libboost-all-dev \
  git

add-apt-repository ppa:bitcoin/bitcoin && \
  apt-get update && \
  apt-get install -y libdb4.8-dev libdb4.8++-dev
  
sudo apt-get install gconf-service libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxss1 libxtst6 libappindicator1 libnss3 libasound2 libatk1.0-0 libc6 ca-certificates fonts-liberation lsb-release xdg-utils wget
```
