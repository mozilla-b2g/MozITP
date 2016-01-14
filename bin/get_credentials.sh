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
rm -rf env-python
virtualenv env-python
source ./env-python/bin/activate

# install packages
pip install -U b2g-util taskcluster-util

# run CLI and login
echo "Please install 'tkinter' if you do not install it."
taskcluster_login --file ./shared/tc_credentials.json

# deactivate
deactivate

# copy credentials file into vm
# cd vm
vagrant up
vagrant scp ./shared/tc_credentials.json default:/home/vagrant/tc_credentials.json

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
