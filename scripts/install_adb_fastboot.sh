#!/bin/bash

# install adb and fastboot
sudo apt-get -y install android-tools-adb android-tools-fastboot

# set up the android rules
sudo rm -rf /etc/udev/rules.d/57-android.rules

# get current file's folder
CUR_DIR=`dirname $0`
# get parent of current file's folder
CUR_PARENT_DIR=`dirname ${CUR_DIR}`
# copy config file of android rules to etc/udev/rules.d folder
sudo cp ${CUR_PARENT_DIR}/config_files/57-android.rules /etc/udev/rules.d/57-android.rules
# change owner and mode
sudo chown root:root /etc/udev/rules.d/57-android.rules
sudo chmod a+x /etc/udev/rules.d/57-android.rules

sudo service udev restart
sudo adb kill-server
sudo adb start-server
