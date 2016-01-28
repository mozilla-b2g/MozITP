#!/bin/bash

# reset adb
sudo service udev restart
sudo adb kill-server
sudo adb start-server

ntpdate -s ntp.ubuntu.com
sudo dpkg-reconfigure --frontend noninteractive tzdata

echo ""
echo "███╗   ███╗ ██████╗ ███████╗██╗████████╗██████╗ "
echo "████╗ ████║██╔═══██╗╚══███╔╝██║╚══██╔══╝██╔══██╗"
echo "██╔████╔██║██║   ██║  ███╔╝ ██║   ██║   ██████╔╝"
echo "██║╚██╔╝██║██║   ██║ ███╔╝  ██║   ██║   ██╔═══╝ "
echo "██║ ╚═╝ ██║╚██████╔╝███████╗██║   ██║   ██║     "
echo "╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚═╝   ╚═╝   ╚═╝     "
echo "                      Built with love           "
echo "                       By the Firefox OS QA Team"
echo ""
