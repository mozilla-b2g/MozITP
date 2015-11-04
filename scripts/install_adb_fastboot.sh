#!/bin/bash

# install adb and fastboot
sudo apt-get -y install android-tools-adb android-tools-fastboot

# set up the android rules
sudo rm -rf /etc/udev/rules.d/57-android.rules
sudo touch /etc/udev/rules.d/57-android.rules

sudo echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="19d2", MODE="0666", GROUP="plugdev"' >> /etc/udev/rules.d/57-android.rules
sudo echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", MODE="0666", GROUP="plugdev"' >> /etc/udev/rules.d/57-android.rules
sudo echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="05c6", MODE="0666", GROUP="plugdev"' >> /etc/udev/rules.d/57-android.rules
sudo echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="1004", MODE="0666", GROUP="plugdev"' >> /etc/udev/rules.d/57-android.rules
sudo echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="1782", MODE="0666", GROUP="plugdev"' >> /etc/udev/rules.d/57-android.rules
sudo echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="2717", MODE="0666", GROUP="plugdev"' >> /etc/udev/rules.d/57-android.rules
sudo echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="0fce", MODE="0666", GROUP="plugdev"' >> /etc/udev/rules.d/57-android.rules

sudo service udev restart
