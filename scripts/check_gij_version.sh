echo -en "gaia version:\t"
cd ~/gaia 
git --no-pager log -n 1 --pretty=format:"%H" 
echo ""
echo -en "last commit:\t"
git --no-pager log -n 1 --pretty=format:"%aN %ad" 
echo ""
echo -en "node version:\t"
node -v
echo -en "npm version:\t"
npm -v
echo -en "python version:\t"
python --version
echo -en "pip version:\t"
pip --version
echo -en "adb version:\t"
adb version
echo -en "Linux version:\t"
uname -s -r -v -m -p -i -o

echo "\"adb devices\" output:"
adb devices


