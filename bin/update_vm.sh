#!/bin/bash

# reset vagrant.d/tmp
rm -rf ~/.vagrant.d/tmp/*

vagrant box update && vagrant destroy

# remove the onceaday cache config files
./bin/clean_cache.sh
