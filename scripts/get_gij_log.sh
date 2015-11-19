#!/bin/bash
# This script must be run in the host machine

cd vm
vagrant scp default:~/gaia/gij_*.log ../shared
vagrant scp default:~/gaia/gij_*.xml ../shared
cd ..


