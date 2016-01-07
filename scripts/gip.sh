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

# Flash to the latest build?

# Clone gaia

sudo apt-get update
sudo apt-get install -y python python-pip xvfb

cd ~/
if [ -f ".users_gaia_exists" ]
then
  echo "You chose to use your own gaia."
else
  if [ -d "gaia" ]
  then
    echo "There is an existing gaia repo, try to update with git pull"
    cd ~/gaia
    git pull
  else
    echo "Cloning the latest gaia repo."
    git clone https://github.com/mozilla-b2g/gaia.git ~/gaia --depth=1 # shallow clone
  fi
fi

cd ~/gaia

sudo pip install virtualenv
virtualenv venv_gip
source ./venv_gip/bin/activate

cd tests/python/gaia-ui-tests
python setup.py develop
pip install -Ur gaiatest/tests/requirements.txt

# Run
adb forward tcp:2828 tcp:2828
echo "{\"acknowledged_risks\":true}" > ~/itp_testvars.json

echo "Running tests for $TEST_FILES"
GAIATEST_SKIP_WARNING=1 gaiatest --address localhost:2828 --testvars ~/itp_testvars.json $TEST_FILES
