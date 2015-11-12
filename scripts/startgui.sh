sudo /usr/share/debconf/fix_db.pl
yes 1 | sudo dpkg-reconfigure dictionaries-common 

sudo apt-get update
#sudo apt-get install -y lxde-core lightdm-gtk-greeter xinit
sudo apt-get install -y lxde-core lightdm-gtk-greeter xinit
#sudo apt-get install -y xfce4 xinit
update-rc.d -f lightdm remove
#echo "uxterm" > ~/.xinitrc

# Write the followin to /etc/xdg/autostart/mozitp.desktop
#[Desktop Entry]
#Type=Application
#Name=MozITP
#Exec=uxterm

sudo cp ~/MozITP/scripts/uxterm-gij.desktop /etc/xdg/autostart/uxterm-gij.desktop

sudo startx
