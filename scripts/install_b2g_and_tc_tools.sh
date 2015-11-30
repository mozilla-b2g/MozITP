#!/bin/bash

# install python tk module
sudo apt-get -y install python python-tk

# install packages for security module
sudo apt-get -y install python-dev libffi-dev libssl-dev zip unzip

# install python packages
sudo apt-get -y install python-setuptools
sudo easy_install pip
sudo pip install -U pip setuptools
sudo pip install -U requests
sudo pip install -U requests[security]

# b2g-util will install taskcluster-util
sudo pip install -U b2g-util==0.0.15
