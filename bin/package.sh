#!/usr/bin/env bash

# Remember to run vagrant box remove MozITP before you repackage
OUTPUT=/tmp/mozitp_$(git rev-parse --short HEAD).box

MOZITP=$(dirname $(dirname $0))

# Need to be run in the root dir
pushd ${MOZITP}

# Reset vm
./bin/reset_vm.sh

# Modify the Vagrantfile for packaging
echo "Preparing the packaing Vagrantfile..."
cat Vagrantfile | sed s/"#config.ssh.insert_key = false"/"config.ssh.insert_key = false"/g > Vagrantfile_4_package
mv Vagrantfile Vagrantfile_backup
mv Vagrantfile_4_package Vagrantfile

# Run once for installing packages
echo "### Installing packages..."
./launch.sh test-speed
vagrant ssh -c "sudo apt-get -y install virtualbox-guest-dkms"
echo "### git clone Gaia..."
vagrant ssh -c "cd ~; git clone --depth=1 https://github.com/mozilla-b2g/gaia.git"

# Package the box
echo "### Doing vagrant package..."
rm -rf ${OUTPUT}
vagrant package --output ${OUTPUT}
ls -lh ${OUTPUT}

# Restore the Vagrantfile
echo "Restoring the Vagrantfile from backup..."
mv Vagrantfile_backup Vagrantfile

# Do tests for Jenkins jobs
echo "### Doing sanity tests..."
./test/all_without_device.sh
RET=`echo $?`
if [[ "${RET}" != "0" ]]
then
    exit ${RET}
fi

popd
