#!/bin/bash

MOZITP=$(dirname $(dirname $0))

pushd ${MOZITP}

function run_test {
  echo "### running $1..."
  ./test/$1
  RET=`echo $?`
  if [[ "${RET}" != "0" ]]
  then
      echo "### $1 failed."
      exit ${RET}
  fi
  echo "### $1 passed"
}

run_test flashtool_sanity_test.sh

run_test gij_phone_mulet_sanity_test.sh
run_test gip_phone_mulet_sanity_test.sh

run_test gij_phone_device_sanity_test.sh
run_test gip_phone_device_sanity_test.sh

popd
