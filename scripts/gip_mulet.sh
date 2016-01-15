# Check if device is connected
# Clone gaia

/home/vagrant/MozITP/util/onceaday.py sudo apt-get update
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
make # Create profile at ~/gaia/profile

sudo pip install virtualenv
virtualenv venv_gip
source ./venv_gip/bin/activate

cd tests/python/gaia-ui-tests
python setup.py develop
pip install -Ur gaiatest/tests/requirements.txt

# Run
adb forward tcp:2828 tcp:2828
echo "{\"acknowledged_risks\":true}" > ~/itp_testvars.json

Xvfb :10 -ac 2> /dev/null & # Open xvfb on display 10, surpressing the error log
export DISPLAY=:10

echo "Running tests for $TEST_FILES"
#GAIATEST_SKIP_WARNING=1 gaiatest --address localhost:2828 --testvars ~/itp_testvars.json $TEST_FILES
GAIATEST_SKIP_WARNING=1 gaiatest --binary=/home/vagrant/gaia/firefox/firefox-bin --profile=/home/vagrant/gaia/profile/ --app-arg=-chrome --app-arg=chrome://b2g/content/shell.html  --testvars ~/itp_testvars.json $TEST_FILES
#GAIATEST_SKIP_WARNING=1 gaiatest --binary=/home/vagrant/gaia/firefox/firefox-bin  --testvars ~/itp_testvars.json $TEST_FILES

killall Xvfb
