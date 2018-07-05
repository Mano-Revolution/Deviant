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
RUN apt-get update && apt-get install -y software-properties-common && \
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

RUN add-apt-repository ppa:bitcoin/bitcoin && \
  apt-get update && \
  apt-get install -y libdb4.8-dev libdb4.8++-dev
```
