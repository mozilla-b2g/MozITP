#!/usr/bin/env bash

MOZITP=$(dirname $(dirname $(dirname $(readlink -f $0))))

bash ${MOZITP}/scripts/install/firefox_trunk.sh

firefox-trunk

