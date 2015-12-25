#!/bin/bash

# common greeting
./greet.sh
./greet_taskcluster.sh

echo "What would you like to do?"
echo ""
echo "  1) Install and run Gaia Integration Test in JavaScript (GIJ)"
echo "  2) Flashing B2G Image (only Aries and Flame)"
echo "  3) Enter interactive shell (bash)"
echo "  0) Exit"
echo ""
echo -n "Please select [ENTER]:"

read CHOICE

case $CHOICE in 
    1)
        ./gij.sh
        ;;
    2)
        ./flash_b2g.sh
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
