#!/bin/bash

THIS_REPO_URL=$(git config --get remote.origin.url | sed 's/git@github.com:/https:\/\/github.com\//g' )
cd vm
if ! vagrant -h | grep scp; then
  vagrant plugin install vagrant-scp
fi
vagrant up
VM_SHELL="vagrant ssh -c"

vagrant scp ../. default:~/MozITP
$VM_SHELL "cat | bash /dev/stdin $THIS_REPO_URL" < ../scripts/provision.sh

# install common modules
$VM_SHELL "bash ~/MozITP/scripts/install_adb_fastboot.sh"
$VM_SHELL "bash ~/MozITP/scripts/install_b2g_and_tc_tools.sh"

case $1 in 
    gij)
        case $2 in
            simulator)
                $VM_SHELL "export APP=$APP; export REPORTER=${REPORTER:-spec}; bash ~/MozITP/scripts/gij.sh" -- -oSendEnv=APP -oSendEnv=REPORTER
                ;;
            emulator)
                echo "Not supported yet"
                ;;
            device)
                echo "Not supported yet"
                ;;
            *)
                $VM_SHELL "export APP=$APP; export REPORTER=${REPORTER:-spec}; bash ~/MozITP/scripts/gij.sh" -- -oSendEnv=APP -oSendEnv=REPORTER
                ;;
        esac
        ;;
    flashtool)
        $VM_SHELL "bash ~/MozITP/scripts/greet_b2g_and_tc_tools.sh"
        $VM_SHELL "bash"
        ;;
    *)
        $VM_SHELL "cd ./MozITP/scripts/; ./menu.sh"
        ;;
esac


# start
# $VM_SHELL "bash ~/MozITP/scripts/startgui.sh"
# $VM_SHELL "cd ./MozITP/scripts/; ./menu.sh"
