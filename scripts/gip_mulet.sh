# Check if device is connected
# Clone gaia

source /home/vagrant/MozITP/scripts/gip_provision.sh

pushd ~/gaia
make #create profile
popd

# Run
adb forward --remove-all
echo "{\"acknowledged_risks\":true}" > ~/itp_testvars.json

Xvfb :10 -ac 2> /dev/null & # Open xvfb on display 10, surpressing the error log
export DISPLAY=:10

echo "Running tests for $TEST_FILES"
#GAIATEST_SKIP_WARNING=1 gaiatest --address localhost:2828 --testvars ~/itp_testvars.json $TEST_FILES
GAIATEST_SKIP_WARNING=1 gaiatest --binary=/home/vagrant/gaia/firefox/firefox-bin --profile=/home/vagrant/gaia/profile/ --app-arg=-chrome --app-arg=chrome://b2g/content/shell.html  --testvars ~/itp_testvars.json $TEST_FILES
#GAIATEST_SKIP_WARNING=1 gaiatest --binary=/home/vagrant/gaia/firefox/firefox-bin  --testvars ~/itp_testvars.json $TEST_FILES

killall Xvfb
