# Check if device is connected
echo "ADB status: " 
adb get-state
if [ "$(adb get-state)" != "device" ]
then 
  echo "Your USB devices:"
  lsusb
  adb devices
  echo "+============================================+"
  echo "| You need to connect your device right now. |"
  echo "| Please plug the device in and try again.   |"
  echo "+============================================+"
  exit 1
fi

/home/vagrant/MozITP/scripts/gip_provision.sh

adb forward tcp:2828 tcp:2828

echo "{\"acknowledged_risks\":true}" > ~/itp_testvars.json

echo "Running tests for $TEST_FILES"
GAIATEST_SKIP_WARNING=1 gaiatest --address localhost:2828 --testvars ~/itp_testvars.json $TEST_FILES
