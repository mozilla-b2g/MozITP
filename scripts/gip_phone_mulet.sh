#!/bin/bash

source /home/vagrant/MozITP/scripts/gip_provision.sh

TIMESTAMP=`date +%Y-%m-%d-%H-%M-%S`

pushd ~/gaia

# check node version
echo "### Node version is:"
node -v

# create profile
echo "### Running Gaia make clean..."
make clean
rm -rf ./node_modules
echo "### Downloading Mulet..."
make mulet
echo "### Creating Gaia profile..."
make

# Run
adb forward --remove-all
echo "{\"acknowledged_risks\":true, \"skip_warning\": true}" > ~/itp_testvars.json

Xvfb :10 -ac 2> /dev/null & # Open xvfb on display 10, surpressing the error log
export DISPLAY=:10

if [[ -z "${TEST_FILES}" ]]
then
    TEST_FILES="/home/vagrant/gaia/tests/python/gaia-ui-tests/gaiatest/tests/functional/manifest.ini"
fi
echo "Running tests for $TEST_FILES"

source ./venv_gip/bin/activate
mkdir -p /home/vagrant/MozITP/shared/GIP/
GAIATEST_SKIP_WARNING=1 gaiatest --binary=/home/vagrant/gaia/firefox/firefox-bin --profile=/home/vagrant/gaia/profile/ --app-arg=-chrome --app-arg=chrome://b2g/content/shell.html --testvars ~/itp_testvars.json --log-html /home/vagrant/MozITP/shared/GIP/${TIMESTAMP}.html ${TEST_FILES}
echo "Output html report to shared/GIP/${TIMESTAMP}.html"
RET=`echo $?`

popd

killall Xvfb

exit ${RET}
