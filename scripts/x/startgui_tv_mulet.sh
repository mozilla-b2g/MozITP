#!/usr/bin/env bash

MOZITP=$(dirname $(dirname $(dirname $(readlink -f $0))))

bash ${MOZITP}/scripts/x/startgui.sh ${MOZITP}/scripts/x/tv_mulet.desktop
