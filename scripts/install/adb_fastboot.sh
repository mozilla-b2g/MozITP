#!/bin/bash

MOZITP=$(dirname $(dirname $(dirname $(readlink -f $0))))

# install adb and fastboot
sudo apt-get -y install android-tools-adb android-tools-fastboot

# set up the android rules
sudo rm -rf /etc/udev/rules.d/57-android.rules

# copy config file of android rules to etc/udev/rules.d folder
sudo cp ${MOZITP}/config_files/57-android.rules /etc/udev/rules.d/57-android.rules
# change owner and mode
sudo chown root:root /etc/udev/rules.d/57-android.rules
sudo chmod a+x /etc/udev/rules.d/57-android.rules

sudo service udev restart
sudo adb kill-server
sudo adb start-server
