# Remember to run vagrant box remove MozITP before you repackage
OUTPUT=/tmp/mozitp_$(git rev-parse --short HEAD).box

MOZITP=$(dirname $(dirname $0))

# Need to be run in the root dir
pushd ${MOZITP}

# reset vm
./bin/reset_vm.sh

# run once for installing packages
echo "### Installing packages..."
./launch.sh test-speed

# do tests
echo "### Doing sanity tests..."
./test/all_without_device.sh
RET=`echo $?`
if [[ "${RET}" != "0" ]]
then
    exit ${RET}
fi

# package the box
echo "### Doing vagrant package..."
vagrant package --output ${OUTPUT}
ls -lh ${OUTPUT}

popd
