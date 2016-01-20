#!/bin/bash

echo "### Installing X Window..."

dpkg -l lxde-core lightdm-gtk-greeter xinit xserver-xorg
RET=`echo $?`
if [[ "${RET}" != "0" ]]
then
    sudo /usr/share/debconf/fix_db.pl
    yes 1 | sudo dpkg-reconfigure dictionaries-common
    sudo apt-get update
    sudo apt-get install -y lxde-core lightdm-gtk-greeter xinit xserver-xorg
    update-rc.d -f lightdm remove
else
    echo "### The X Window was installed."
fi

