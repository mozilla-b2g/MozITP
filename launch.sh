THIS_REPO_URL=$(git config --get remote.origin.url | sed 's/git@github.com:/https:\/\/github.com\//g' )
cd vm
vagrant up
VM_SHELL="vagrant ssh -c"

$VM_SHELL "cat | bash /dev/stdin $THIS_REPO_URL" < ../scripts/provision.sh  

# Install Android's tools: adb and fastboot
$VM_SHELL "bash ~/MozITP/scripts/install_adb_fastboot.sh"

# Install B2G and Taskcluster tools
$VM_SHELL "bash ~/MozITP/scripts/install_b2g_and_tc_tools.sh"

# start
$VM_SHELL "bash ~/MozITP/scripts/startgui.sh"
# $VM_SHELL "cd ./MozITP/scripts/; ./menu.sh"
