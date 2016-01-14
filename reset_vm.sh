#!/bin/bash

#pushd vm
vagrant destroy
#popd

# remove the onceaday cache config files
./reset_onceaday.sh
