#!/bin/bash

cd vm
vagrant destroy

# remove the onceaday cache config files
./reset_onceaday.sh
