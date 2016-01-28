# Install NVM
source /home/vagrant/MozITP/scripts/install/nvm.sh

/home/vagrant/MozITP/util/onceaday.py "sudo apt-get update"

pushd ~/
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
popd


pushd ~/gaia

sudo pip install virtualenv
virtualenv venv_gip
source ./venv_gip/bin/activate

pushd tests/python/gaia-ui-tests
python setup.py develop
pip install -Ur gaiatest/tests/requirements.txt
popd

popd
