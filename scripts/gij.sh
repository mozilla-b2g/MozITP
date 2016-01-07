#!/bin/bash
#if [ $EUID -eq 0 ]; then #Don't run as root
  #su vagrant -c "/home/vagrant/MozITP/scripts/gij.sh" #fi

# If you don't want to run GIJ setup again, set the env var to GIJ_NO_SETUP=true
NODE_VER="4.2"

SCRIPT_PATH="`dirname \"$0\"`"
echo "[ITP] Running tests for $APP"

if [ -z $GIJ_NO_SETUP ]
then 
  $SCRIPT_PATH/gij_provision.sh
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
