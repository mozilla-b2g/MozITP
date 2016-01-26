#!/bin/bash

# reset vm
vagrant destroy

# reset vagrant.d/tmp
rm -rf ~/.vagrant.d/tmp/*

# remove the onceaday cache config files
./bin/clean_cache.sh
