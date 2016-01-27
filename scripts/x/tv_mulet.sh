#!/usr/bin/env bash

source /home/vagrant/MozITP/scripts/gip_provision.sh

pushd ~/gaia

# clean
#make really-clean
make clean

# download mulet
make mulet

# create TV profile
GAIA_DEVICE_TYPE=tv DEVICE_DEBUG=1 make

./firefox/firefox-bin -screen=1952×1141 -profile `pwd`/profile

read

popd

