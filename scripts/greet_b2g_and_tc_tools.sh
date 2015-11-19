#!/bin/bash

# print usages
echo ""
echo " ============================================== "
echo "  Get temporary credentials from:               "
echo "  - https://auth.taskcluster.net/               "
echo ""
echo "  Flash B2G builds:                             "
echo "  - Run 'b2g_flash_taskcluster --help'          "
echo ""
echo "  Download artifacts from Taskcluster:          "
echo "  - Run 'taskcluster_traverse --help'           "
echo " ============================================== "
echo ""

# TODO: interactive menu for downloading/flashing builds for different devices?

FILE_PATH="$HOME/tc_credentials.json"

function setup_credentials() {
    echo ""
    echo " ============================================== "
    echo "  Please open browser,                          "
    echo "  access https://auth.taskcluster.net           "
    echo "  and sign-in to get Temporary Credentials.     "
    echo " ============================================== "
    echo ""
    read -p "Enter your ClientId? [Enter]
" -s CLIENT_ID
    read -p "Enter your AccessToken? [Enter]
" -s ACCESS_TOKEN
    read -p "Enter your Certificate? [Enter]
" -s CERT

    touch $FILE_PATH
    echo -e "{\n\"clientId\": \"${CLIENT_ID}\",\n\"accessToken\": \"${ACCESS_TOKEN}\",\n\"certificate\": ${CERT}\n}" > $FILE_PATH
}

if [[ ! -f ${FILE_PATH} ]]
then
    echo "Can not find your credentials file."
    setup_credentials
else
    echo "You have credentials file at ${FILE_PATH}"
    echo ""
    echo "Would you like to use this credentials?"
    echo "(If not, we will remove it and you can enter new one.)"
    read -p "[Y/n]" CHOICE
    case $CHOICE in
        [nN])
            rm -f ${FILE_PATH}.back
            mv ${FILE_PATH} ${FILE_PATH}.back
            echo "Backup old credentials to ${FILE_PATH}.back"
            setup_credentials
            ;;
        *)
            echo "Keep going..."
            ;;
        esac
fi


function select_eng_user() {
    while true
    do
        echo "What would you like to do?"
        echo ""
        echo "  1) Engineer Build"
        echo "  2) User Build"
        echo "  0) Exit"
        echo ""
        echo -n "Please select [ENTER]:"

        read CHOICE

        case $CHOICE in
            1)
                POST_NAME="-eng-opt"
                break
                ;;
            2)
                POST_NAME="-opt"
                break
                ;;
            0)
                exit 0
                ;;
            *)
                echo "Not a valid option, try again."
                ;;
        esac
    done
}

function select_branch() {
    while true
    do
        echo "What would you like to do?"
        echo ""
        echo "  1) Mozilla-Central"
        echo "  2) B2G v2.5 (Mozilla 44)"
        echo "  0) Exit"
        echo ""
        echo -n "Please select [ENTER]:"

        read CHOICE

        case $CHOICE in
            1)
                BRANCH_NAME="mozilla-central"
                break
                ;;
            2)
                BRANCH_NAME="mozilla-b2g44_v2_5"
                break
                ;;
            0)
                exit 0
                ;;
            *)
                echo "Not a valid option, try again."
                ;;
        esac
    done
}

DEVICE=`adb shell getprop ro.product.device 2> /dev/null`
RET=$?
if [[ ${RET} -ne 0 ]]
then
    echo "You should connect your device!"
    exit 0
fi

DEVICE=`echo ${DEVICE} | tr -d '\n' | tr -d '\r'`
BUILD_PATH="private/build/"

if [[ "${DEVICE}" == "flame" ]]
then
    echo "Get Flame!!"
    DEVICE_NAME="flame-kk"
    IMAGE_NAME="flame-kk.zip"
    select_branch
    select_eng_user

elif [[ "${DEVICE}" == "aries" ]]
then
    echo "Get Aries!!"
    DEVICE_NAME="aries"
    IMAGE_NAME="private/build/aries.zip"
    select_branch
    select_eng_user

else
    echo "Get ${DEVICE}, not Flame or Aries."
    echo "Please enter \"interactive shell\" mode to download builds!"
fi

NAMESPACE="gecko.v2.${BRANCH_NAME}.latest.b2g.${DEVICE_NAME}${POST_NAME}"
IMAGE_PATH="${BUILD_PATH}${IMAGE_NAME}"

echo "Download ${IMAGE_NAME} from ${NAMESPACE}, right?"
read -p "[Y/n]" CHOICE
case $CHOICE in
    [nN])
        echo "Cancel."
        exit 0
        ;;
    *)
        ;;
esac


CUR_DIR=`pwd`
DATE=`date +%Y-%m-%d`
DEST_DIR="${CUR_DIR}/DATE/"

echo "Download ${IMAGE_NAME} from ${NAMESPACE} to ${DEST_DIR} ..."
taskcluster_download -n ${NAMESPACE} -a ${IMAGE_PATH} -d ${DEST_DIR}
echo "Download finished."

echo "Unzip ..."
unzip -o ${DEST_DIR}/${IMAGE_NAME} -d ${DEST_DIR}

echo "Flashing ..."
cd ${DEST_DIR}/b2g-distro/
bash ./flash.sh
cd ${CUR_DIR}
b2g_check_versions
