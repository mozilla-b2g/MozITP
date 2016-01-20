#!/usr/bin/env bash

MOZITP=$(dirname $(dirname $(dirname $(readlink -f $0))))

echo "### Setting up the desktop file: $1"

bash ${MOZITP}/scripts/install/xwindow.sh

echo "### Updating /etc/xdg/autostart/MozITP.desktop file..."
sudo rm -rf /etc/xdg/autostart/MozITP.desktop
sudo cp $1 /etc/xdg/autostart/MozITP.desktop

LOG=`mktemp -t startx_log.XXXXXXXX`
echo "### startx_log: $LOG"
echo "### startx, please switch to VM."
echo "### ^C will back to menu."
sudo startx >> "${LOG}" 2>&1
