# Install NVM
NVM_VER="v0.29.0"
NODE_VER="4.2.2"

sudo apt-get update
sudo apt-get install -y build-essential libssl-dev \
  libgtk-3-0 \
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
git clone https://github.com/mozilla-b2g/gaia.git ~/gaia --depth=3 # shallow clone
cd ~/gaia

npm install -g node-gyp # Resolve the node-gyp rebuild hang problem
