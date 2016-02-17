#!/bin/bash
STARTTIME=$(date +%s)

THIS_REPO_URL=$(git config --get remote.origin.url | sed 's/git@github.com:/https:\/\/github.com\//g' )

if ! vagrant plugin list | grep scp > /dev/null; then
    vagrant plugin install vagrant-scp
fi

# Vagrant up will also rsync the required files from host to guest (one-time, one-way). See Vagrantfile for more detail.
TMP=`mktemp 2> /dev/null || mktemp -t tmp`
vagrant up | tee >(grep "is already running" > ${TMP})
RET=`cat ${TMP}`
if [[ "${RET}" != "" ]]
then
    echo "VM is already running, do rsync..."
    vagrant rsync
fi
rm -rf ${TMP}

VM_SHELL="vagrant ssh -c"

# install all packages
./util/onceaday.py "${VM_SHELL} \"bash ~/MozITP/scripts/install/all.sh ${THIS_REPO_URL}\""

function mulet_test {
    ${VM_SHELL} "export APP=$APP; export TEST_FILES=$TEST_FILES; export REPORTER=${REPORTER:-spec}; export TEST_MANIFEST=$TEST_MANIFEST; bash ~/MozITP/scripts/gij_phone_mulet.sh" -- -oSendEnv=APP -oSendEnv=TEST_FILES -oSendEnv=REPORTER -oSendEnv=REPORTER
}

function tv_mulet_test {
    ${VM_SHELL} "export APP=$APP; export TEST_FILES=$TEST_FILES; export REPORTER=${REPORTER:-spec}; export TEST_MANIFEST=$TEST_MANIFEST; bash ~/MozITP/scripts/gij_tv_mulet.sh" -- -oSendEnv=APP -oSendEnv=TEST_FILES -oSendEnv=REPORTER -oSendEnv=REPORTER
}

function device_test {
    ${VM_SHELL} "export APP=$APP; export TEST_FILES=$TEST_FILES; export REPORTER=${REPORTER:-spec}; bash ~/MozITP/scripts/gij_phone_device.sh" -- -oSendEnv=APP -oSendEnv=TEST_FILES -oSendEnv=REPORTER
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
                echo "The emulator is too slow for GIJ, if you still wish to run, checkout scripts/gij_phone_emulator.sh"
                ;;
            device)
                device_test
                ;;
            *)
                mulet_test
                ;;
        esac
        ;;
    gij-tv)
        tv_mulet_test
        ;;
    gip)
        case $2 in
            simulator)
                ${VM_SHELL} "export TEST_FILES=$TEST_FILES; bash ~/MozITP/scripts/gip_phone_mulet.sh -- -oSendEnv=TEST_FILES"
                ;;
            emulator)
                echo "The emulator is too slow for GIP, if you still wish to run, checkout scripts/gij_phone_emulator.sh"
                ;;
            device)
                ${VM_SHELL} "export TEST_FILES=$TEST_FILES; bash ~/MozITP/scripts/gip_phone_device.sh -- -oSendEnv=TEST_FILES"
                ;;
            *)
                ${VM_SHELL} "export TEST_FILES=$TEST_FILES; bash ~/MozITP/scripts/gip_phone_mulet.sh -- -oSendEnv=TEST_FILES"
                ;;
        esac
        ;;
    flashtool)
        ${VM_SHELL} "bash ~/MozITP/scripts/flash_b2g.sh"
        ;;
    fuzz)
        if [ -z "$2" ]
        then
          echo "Usage:"
          echo "    launch.sh fuzz <testcases.zip>"
          exit 1
        fi
        $VM_SHELL "mkdir ~/fuzz"
        vagrant scp "$2" default:~/fuzz 
        $VM_SHELL "bash ~/MozITP/scripts/fuzz_executor.sh $2"
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
else
    # Pull the shared folder from guest to host by scp. See "./util/simplefilter.list" for more detail.
    echo "Running scp to get the files from guest vm to host..."
    ./util/simplefilter.py ./ ./util/.simplefilter.list | while read line; do vagrant scp default:~/MozITP/$line ./; done
fi
