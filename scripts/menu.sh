#!/bin/bash

# common greeting
./greet.sh
./greet_taskcluster.sh

echo "What would you like to do?"
echo ""
echo "  1) Install and run Gaia Integration Test in JavaScript (GIJ)"
echo "  2) Install tools for downloading & flashing B2G (b2g_util & taskcluster_util)"
echo "  3) Enter interactive shell (bash)"
echo "  0) Exit"
echo ""
echo -n "Please select [ENTER]:"

read CHOICE

case $CHOICE in 
    1)
        ./install_adb_fastboot.sh;
        ./gij.sh
        ;;
    2)
        ./greet_b2g_and_tc_tools.sh
        bash
        ;;
    3)
        bash
        ;;
    0)
        exit
        ;;
    *)
        echo "Not a valid option, try again."
        ;;
esac

./menu.sh
