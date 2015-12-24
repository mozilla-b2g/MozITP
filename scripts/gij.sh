#!/bin/bash
#if [ $EUID -eq 0 ]; then #Don't run as root
  #su vagrant -c "/home/vagrant/MozITP/scripts/gij.sh" #fi

# If you don't want to run GIJ setup again, set the env var to GIJ_NO_SETUP=true

NVM_VER="v0.29.0"
NODE_VER="4.2.2"

echo "[ITP] Running tests for $APP"

if [ -z $GIJ_NO_SETUP ]
then 
  # Install NVM
  sudo apt-get update
  sudo apt-get install -y build-essential libssl-dev \
                          libgtk-3-0 \
                          clang \
                          pcregrep 
  # libgtk-3-0: for running Firefox (Mulet)
  # clang: for building sockit-to-me
  # pcregrep: for parsing the xunit test report
  curl -o- https://raw.githubusercontent.com/creationix/nvm/$NVM_VER/install.sh | bash #Notice the version may change
  source ~/.nvm/nvm.sh
  nvm install $NODE_VER
  nvm use $NODE_VER

  # Get gaia code
  sudo apt-get install -y libfontconfig1 libasound2 libgtk2.0-0 python-pip
  sudo apt-get install -y xvfb 
  # sudo apt-get install -y x11vnc vncviewer
  git clone https://github.com/mozilla-b2g/gaia.git ~/gaia --depth=3 # shallow clone
  cd ~/gaia

  npm install -g node-gyp # Resolve the node-gyp rebuild hang problem
fi

source ~/.nvm/nvm.sh
nvm use $NODE_VER
cd ~/gaia

# Headless run
Xvfb :10 -ac 2> /dev/null & # Open xvfb on display 10, surpressing the error log
export DISPLAY=:10
# x11vnc -display :10 -clip 600x600+0+0 -localhost &
# echo "If you want to see the simulator screen, run \`vncviewer :0\`"

: ${APP=all}

timestamp=$(date +"%Y%m%d-%H%M%S")
export NODE_DEBUG=*
export HOST_LOG=stdout
make test-integration 2>&1 | tee gij_$timestamp.raw.log

killall Xvfb
# xunit report is not stable right now
#cat gij_$timestamp.raw.log | pcregrep --locale en_US.UTF-8 -M "<testsuite((.|\n)*)testsuite>" > gij_$timestamp.log.xml

#cp gij_$timestamp.log.xml ~/shared
# echo "Click any key to close this window..."
# read
