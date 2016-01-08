#!/bin/bash

# print usages
echo ""
echo " ============================================== "
echo "  Get temporary credentials from:               "
echo "  - https://auth.taskcluster.net/               "
echo "  - or run './get_credentials.sh'               "
echo ""
echo "  Flash B2G builds:                             "
echo "  - Run 'b2g_flash_taskcluster --help'          "
echo ""
echo "  Download artifacts from Taskcluster:          "
echo "  - Run 'taskcluster_traverse --help'           "
echo " ============================================== "
echo ""

# call tool of b2g_util
b2g_quick_flash
RET=`echo $?`
if [[ "$RET" != "0" ]]
then
    echo "The result of adb devices:"
    adb devices
    echo "Reset adb service..."
    sudo service udev restart
    sudo adb kill-server
    sudo adb start-server
    echo "Please re-connect your device, and try again."
fi
