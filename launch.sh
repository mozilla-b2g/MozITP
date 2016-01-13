#!/bin/bash
STARTTIME=$(date +%s)

THIS_REPO_URL=$(git config --get remote.origin.url | sed 's/git@github.com:/https:\/\/github.com\//g' )
# swtich folder to sub-folder "vm"
pushd vm

if ! vagrant -h | grep scp; then
  vagrant plugin install vagrant-scp
fi
vagrant up
VM_SHELL="vagrant ssh -c"

# speed up scp by filter the first level files and folders
$VM_SHELL "mkdir -p ~/MozITP"
../util/simplefilter.py ../ ../util/.simplefilter.list | while read line; do vagrant scp $line default:~/MozITP; done

# setup git, github ssh key and apt-get update
../util/onceaday.py "$VM_SHELL \"cat | bash /dev/stdin $THIS_REPO_URL\" < ../scripts/provision.sh"

# install common modules
../util/onceaday.py "$VM_SHELL \"bash ~/MozITP/scripts/install/adb_fastboot.sh\""
../util/onceaday.py "$VM_SHELL \"bash ~/MozITP/scripts/install/b2g_and_tc_tools.sh\""

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
    test-speed)
        # do nothing, for testing launch time
        ;;
    *)
        $VM_SHELL "cd ./MozITP/scripts/; ./greet/mozitp.sh; ./greet/taskcluster.sh; ./menu.sh"
        ;;
esac

popd

# for testing launch time
ENDTIME=$(date +%s)
if [[ "$1" == "test-speed" ]]
then
    echo "It takes $((${ENDTIME} - ${STARTTIME})) seconds"
fi