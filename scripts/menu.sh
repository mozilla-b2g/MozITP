#!/bin/bash

# common greeting
./greet.sh
./greet_taskcluster.sh

echo "What would you like to do?"
echo ""
echo "  1) Run Gaia Integration Test (GIJ) on Mulet"
echo "  2) Run Gaia Integration Test (GIJ) on Real Device"
echo "  3) Flashing B2G Image (only Aries and Flame)"
echo "  4) Enter interactive shell (bash)"
echo "  0) Exit"
echo ""
echo -n "Please select [ENTER]:"

read CHOICE

case $CHOICE in 
    1)
        ./gij.sh
        ;;
    2)
        ./gij_device.sh
        ;;
    3)
        ./flash_b2g.sh
        ;;
    4)
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
