#!/bin/bash

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

: ${APP=all}

timestamp=$(date +"%Y%m%d-%H%M%S")
export NODE_DEBUG=*
export HOST_LOG=stdout
export GAIA_DEVICE_TYPE=tv
#./bin/ci run marionette_js 2>&1 | tee gij_$timestamp.raw.log
make test-integration 2>&1 | tee gij_$timestamp.raw.log
RET=`echo $?`

killall Xvfb

exit ${RET}