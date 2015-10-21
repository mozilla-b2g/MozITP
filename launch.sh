THIS_REPO_URL=$(git config --get remote.origin.url | sed 's/git@github.com:/https:\/\/github.com\//g' )
cd vm
vagrant up
VM_SHELL="vagrant ssh -c"
$VM_SHELL "sudo apt-get install -y git"
$VM_SHELL "sudo ssh-keyscan github.com >> ~/.ssh/known_hosts"
$VM_SHELL "rm -rf MozITP" # Cleanup old repo
$VM_SHELL "git clone $THIS_REPO_URL" #TODO: Do we need special folder?

$VM_SHELL "cd ./MozITP/scripts/; ./menu.sh"
# cd ..
