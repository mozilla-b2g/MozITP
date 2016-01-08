#!/bin/bash

THIS_REPO_URL=$(git config --get remote.origin.url | sed 's/git@github.com:/https:\/\/github.com\//g' )
# swtich folder to sub-folder "vm"
cd vm
if ! vagrant -h | grep scp; then
  vagrant plugin install vagrant-scp
fi
vagrant up
VM_SHELL="vagrant ssh -c"

vagrant scp ../. default:~/MozITP
$VM_SHELL "cat | bash /dev/stdin $THIS_REPO_URL" < ../scripts/provision.sh

# install common modules
$VM_SHELL "bash ~/MozITP/scripts/install/adb_fastboot.sh"
$VM_SHELL "bash ~/MozITP/scripts/install/b2g_and_tc_tools.sh"

function mulet_test {
    $VM_SHELL "export APP=$APP; export TEST_FILES=$TEST_FILES; export REPORTER=${REPORTER:-spec}; bash ~/MozITP/scripts/gij.sh" -- -oSendEnv=APP -oSendEnv=TEST_FILES -oSendEnv=REPORTER
}

function device_test {
    $VM_SHELL "export APP=$APP; export TEST_FILES=$TEST_FILES; export REPORTER=${REPORTER:-spec}; bash ~/MozITP/scripts/gij_device.sh" -- -oSendEnv=APP -oSendEnv=TEST_FILES -oSendEnv=REPORTER
}

if [ "$GAIA" ]
then
  vagrant scp $GAIA default:~/gaia
  $VM_SHELL "touch ~/.users_gaia_exists"
fi

case $1 in 
    gij)
        case $2 in
            simulator)
                mulet_test
                ;;
            emulator)
                echo "Not supported yet"
                ;;
            device)
                device_test
                ;;
            *)
                mulet_test
                ;;
        esac
        ;;
    gip)
        $VM_SHELL "export TEST_FILES=$TEST_FILES; bash ~/MozITP/scripts/gip.sh -- -oSendEnv=TEST_FILES"
        ;;
    flashtool)
        $VM_SHELL "bash ~/MozITP/scripts/flash_b2g.sh"
        $VM_SHELL "bash"
        ;;
    *)
        $VM_SHELL "cd ./MozITP/scripts/; ./greet/mozitp.sh; ./greet/taskcluster.sh; ./menu.sh"
        ;;
esac


# start
# $VM_SHELL "bash ~/MozITP/scripts/startgui.sh"
# $VM_SHELL "cd ./MozITP/scripts/; ./menu.sh"
