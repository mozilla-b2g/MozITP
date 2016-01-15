#!/bin/bash
STARTTIME=$(date +%s)

THIS_REPO_URL=$(git config --get remote.origin.url | sed 's/git@github.com:/https:\/\/github.com\//g' )

if ! vagrant plugin list | grep scp > /dev/null; then
    vagrant plugin install vagrant-scp
fi

# Vagrant up will also rsync the required files from host to guest (one-time, one-way). See Vagrantfile for more detail.
vagrant up
VM_SHELL="vagrant ssh -c"

# install all packages
./util/onceaday.py "${VM_SHELL} \"bash ~/MozITP/scripts/install/all.sh ${THIS_REPO_URL}\""

function mulet_test {
    ${VM_SHELL} "export APP=$APP; export TEST_FILES=$TEST_FILES; export REPORTER=${REPORTER:-spec}; bash ~/MozITP/scripts/gij.sh" -- -oSendEnv=APP -oSendEnv=TEST_FILES -oSendEnv=REPORTER
}

function device_test {
    ${VM_SHELL} "export APP=$APP; export TEST_FILES=$TEST_FILES; export REPORTER=${REPORTER:-spec}; bash ~/MozITP/scripts/gij_device.sh" -- -oSendEnv=APP -oSendEnv=TEST_FILES -oSendEnv=REPORTER
}

if [ "$GAIA" ]
then
    vagrant scp $GAIA default:~/gaia
    ${VM_SHELL} "touch ~/.users_gaia_exists"
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
        case $2 in
            simulator)
                ${VM_SHELL} "export TEST_FILES=$TEST_FILES; bash ~/MozITP/scripts/gip_mulet.sh -- -oSendEnv=TEST_FILES"
                ;;
            emulator)
                echo "Not supported yet"
                ;;
            device)
                ${VM_SHELL} "export TEST_FILES=$TEST_FILES; bash ~/MozITP/scripts/gip.sh -- -oSendEnv=TEST_FILES"
                ;;
            *)
                ${VM_SHELL} "export TEST_FILES=$TEST_FILES; bash ~/MozITP/scripts/gip_mulet.sh -- -oSendEnv=TEST_FILES"
                ;;
        esac
        ;;
    flashtool)
        ${VM_SHELL} "bash ~/MozITP/scripts/flash_b2g.sh"
        ${VM_SHELL} "bash"
        ;;
    test-speed)
        # do nothing, for testing launch time
        ;;
    *)
        ${VM_SHELL} "cd ./MozITP/scripts/; ./greet/mozitp.sh; ./greet/taskcluster.sh; ./menu.sh"
        ;;
esac


# for testing launch time
ENDTIME=$(date +%s)
if [[ "$1" == "test-speed" ]]
then
    echo "It takes $((${ENDTIME} - ${STARTTIME})) seconds"
fi
