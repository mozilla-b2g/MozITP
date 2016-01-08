#ITP_REPO_URL="https://github.com/Mozilla-TWQA/MozITP"
ITP_REPO_URL=$1
export LC_ALL="en_US.UTF-8";

# check the latest update timestamp
if [[ ! -f "/var/lib/apt/periodic/update-success-stamp" ]]
then
    echo "### First run of apt-get update, updating..."
    sudo apt-get update
else
    NOW=`date +"%s"`
    LATEST_UPDATE=`stat -c %Y /var/lib/apt/periodic/update-success-stamp`
    DIFF=$((${NOW} - ${LATEST_UPDATE}))
    ONE_DAY=$((24 * 60 * 60))
    if [[ ${DIFF} -gt ${ONE_DAY} ]]
    then
        echo "### Latest apt-get update more than one day (timestamp diff ${DIFF}), updating..."
        sudo apt-get update
    else
        echo "### Latest apt-get update less than one day (timestamp diff ${DIFF}), skip."
    fi
fi

sudo apt-get install -y git
sudo ssh-keyscan github.com >> ~/.ssh/known_hosts
