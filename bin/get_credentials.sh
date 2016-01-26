#!/bin/bash

# check virtualenv
which virtualenv > /dev/null
RET=$?
if [[ ${RET} != 0 ]]
then
    echo "There is no Python package 'virtualenv' in your environment, please install it."
    exit 1
fi

# create and activate env
virtualenv env-python
source ./env-python/bin/activate

# install packages
pip install -U pip b2g-util taskcluster-util

# run CLI and login
taskcluster_login

# deactivate
deactivate

# copy credentials file into vm
vagrant up
vagrant scp ~/tc_credentials.json default:/home/vagrant/tc_credentials.json

# halt VM or not.
read -p "Let VM keep running? [Y/n]" CHOICE
case $CHOICE in
    [nN])
        echo "Stopping VM ..."
        vagrant halt
        ;;
    *)
        echo "VM keep running ..."
        ;;
esac
