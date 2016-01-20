#!/bin/bash

MOZITP=$(dirname $(dirname $(dirname $(readlink -f $0))))
THIS_REPO_URL=$1

# setup git, github ssh key and apt-get update
bash ${MOZITP}/scripts/install/system_provision.sh ${THIS_REPO_URL}

# install common modules
bash ${MOZITP}/scripts/install/adb_fastboot.sh
bash ${MOZITP}/scripts/install/b2g_and_tc_tools.sh
bash ${MOZITP}/scripts/install/xwindow.sh
bash ${MOZITP}/scripts/install/firefox_trunk.sh
