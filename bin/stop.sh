#!/bin/bash

MOZITP=$(dirname $(dirname $0))
pushd ${MOZITP}

if ! vagrant plugin list | grep scp > /dev/null; then
    vagrant plugin install vagrant-scp
fi

# Pull the shared folder from guest to host by scp. See "./util/simplefilter.list" for more detail.
echo "Running scp to get the files from guest vm to host..."
./util/simplefilter.py ./ ./util/.simplefilter.list | while read line; do vagrant scp default:~/MozITP/$line/* ./$line/; done

vagrant halt

popd
