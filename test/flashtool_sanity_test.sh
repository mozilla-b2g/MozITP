#!/bin/bash
set -e
#yes q | ./launch.sh flashtool | grep -E "Can not find device|Device found"
yes q | ./launch.sh flashtool 2>&1 | grep -E "Can not find device|Device found"
exit $?
