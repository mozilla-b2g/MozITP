echo -en "gaia version:\t"
pushd ~/gaia
git --no-pager log -n 1 --pretty=format:"%H" 
git --no-pager log -n 1 --pretty=format:"%aN %ad" 
popd
echo -en "node version:\t"
node -v
echo -en "npm version:\t"
npm -v
echo -en "python version:\t"
python --version
echo -en "pip version:\t"
pip --version
echo -en "Linux version:\t"
uname -s -r -v -m -p -i -o


