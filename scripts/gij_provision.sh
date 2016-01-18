# Install NVM
NVM_VER="v0.29.0"
NODE_VER="4.2.2"

/home/vagrant/MozITP/util/onceaday.py "sudo apt-get update"
sudo apt-get install -y build-essential libssl-dev \
  libgtk-3-0 \
  libasound2 \
  libgtk2.0-0 \
  clang \
  pcregrep 

# libgtk-3-0: for running Firefox (Mulet)
# clang: for building sockit-to-me
# pcregrep: for parsing the xunit test report
curl -o- https://raw.githubusercontent.com/creationix/nvm/$NVM_VER/install.sh | bash #Notice the version may change
source ~/.nvm/nvm.sh
nvm install $NODE_VER
nvm use $NODE_VER

# Get gaia code
sudo apt-get install -y libfontconfig1 libasound2 libgtk2.0-0 python-pip
sudo apt-get install -y xvfb 
# sudo apt-get install -y x11vnc vncviewer
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

npm install -g node-gyp # Resolve the node-gyp rebuild hang problem
