#!/bin/bash

# install nvm
NVM_VER="v0.30.2"
NODE_VER="4.2.2"

pushd ~
echo "### Installing nvm..."

curl -o- https://raw.githubusercontent.com/creationix/nvm/${NVM_VER}/install.sh | bash
if [[ `grep "source ~/.nvm/nvm.sh" ~/.bashrc` ]]
then
    echo "" >> ~/.bashrc
    echo "source ~/.nvm/nvm.sh" >> ~/.bashrc
fi
source ~/.nvm/nvm.sh

echo "### Installing node ${NODE_VER}..."
nvm install ${NODE_VER}
nvm use ${NODE_VER}
nvm alias default ${NODE_VER}

# Resolve the node-gyp rebuild hang problem
echo "### Installing node-gyp..."
npm -g list | grep node-gyp
RET=`echo $?`
if [[ "${RET}" == "0" ]]
then
    echo "### node-gyp is already installed."
else
    npm install -g node-gyp
fi

node -v

popd
