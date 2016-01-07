#!/usr/bin/env bash

echo "### Setting up the desktop file: $1"

sudo /usr/share/debconf/fix_db.pl
yes 1 | sudo dpkg-reconfigure dictionaries-common

sudo apt-get update
sudo apt-get install -y lxde-core lightdm-gtk-greeter xinit
update-rc.d -f lightdm remove

echo "### Updating /etc/xdg/autostart/MozITP.desktop file..."
sudo rm -rf /etc/xdg/autostart/MozITP.desktop
sudo cp $1 /etc/xdg/autostart/MozITP.desktop

LOG=`mktemp -t startx_log.XXXXXXXX`
echo "### startx_log: $LOG"
echo "### startx, please switch to VM."
echo "### ^C will back to menu."
sudo startx >> "${LOG}" 2>&1
