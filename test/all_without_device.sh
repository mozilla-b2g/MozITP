#!/bin/bash

MOZITP=$(dirname $(dirname $0))

pushd ${MOZITP}

echo "### running gij_sanity_test..."
./test/gij_sanity_test.sh
RET=`echo $?`
if [[ "${RET}" != "0" ]]
then
    echo "### gij_sanity_test failed."
    exit ${RET}
fi

echo "### running gip_phone_mulet_sanity_test..."
./test/gip_phone_mulet_sanity_test.sh
RET=`echo $?`
if [[ "${RET}" != "0" ]]
then
    echo "### gip_phone_mulet_sanity_test failed."
    exit ${RET}
fi

echo "### running flashtool_sanity_test..."
./test/flashtool_sanity_test.sh
RET=`echo $?`
if [[ "${RET}" != "0" ]]
then
    echo "### flashtool_sanity_test failed."
    exit ${RET}
fi

popd
