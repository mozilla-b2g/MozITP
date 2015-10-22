THIS_REPO_URL=$(git config --get remote.origin.url | sed 's/git@github.com:/https:\/\/github.com\//g' )
cd vm
vagrant up
VM_SHELL="vagrant ssh -c"

$VM_SHELL "cat | bash /dev/stdin $THIS_REPO_URL" < ../scripts/provision.sh  
# $VM_SHELL "bash ~/MozITP/scripts/startgui.sh"
$VM_SHELL "cd ./MozITP/scripts/; ./menu.sh"
