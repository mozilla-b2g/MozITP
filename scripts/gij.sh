#!/bin/bash
#if [ $EUID -eq 0 ]; then #Don't run as root
  #su vagrant -c "/home/vagrant/MozITP/scripts/gij.sh" #fi

NVM_VER="v0.29.0"

echo "[ITP] Running tests for $APP"

# Install NVM
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev pcregrep
curl -o- https://raw.githubusercontent.com/creationix/nvm/$NVM_VER/install.sh | bash #Notice the version may change
source ~/.nvm/nvm.sh
nvm install 0.12
nvm use 0.12

# Get gaia code
sudo apt-get install -y libfontconfig1 libasound2 libgtk2.0-0 python-pip
sudo apt-get install -y xvfb 
# sudo apt-get install -y x11vnc vncviewer
git clone https://github.com/mozilla-b2g/gaia.git ~/gaia --depth=3 # shallow clone
cd ~/gaia

npm install -g node-gyp # Resolve the node-gyp rebuild hang problem

# Headless run
Xvfb :10 -ac 2> /dev/null & # Open xvfb on display 10, surpressing the error log
export DISPLAY=:10
# x11vnc -display :10 -clip 600x600+0+0 -localhost &
# echo "If you want to see the simulator screen, run \`vncviewer :0\`"

: ${APP=all}

timestamp=$(date +"%Y%m%d-%H%M%S")
make test-integration 2>&1 | tee gij_$timestamp.raw.log

killall Xvfb
cat gij_$timestamp.raw.log | pcregrep --locale en_US.UTF-8 -M "<testsuite((.|\n)*)testsuite>" > gij_$timestamp.log.xml

#cp gij_$timestamp.log.xml ~/shared
# echo "Click any key to close this window..."
# read
