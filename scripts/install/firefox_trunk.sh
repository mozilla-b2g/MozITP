#!/bin/bash

# install Firefox
echo "### Installing firefox-trunk..."
dpkg -l firefox-trunk
RET=`echo $?`
if [[ "${RET}" != "0" ]]
then
    sudo add-apt-repository -y ppa:ubuntu-mozilla-daily/ppa
    sudo apt-get update
    sudo apt-get install -y firefox-trunk
else
    echo "### The firefox-trunk was installed."
fi

# checking the add-on
echo "### Installing b2g-installer add-on..."
test -d /home/vagrant/.mozilla/firefox-trunk/MozITP.default/extensions/b2g-installer@mozilla.org/
RET=`echo $?`
if [[ "${RET}" == "0" ]]
then
    echo "### The b2g-installer add-on was installed."
else
    # install add-on
    TEMPD=`mktemp -d`
    unzip -d ${TEMPD} /home/vagrant/MozITP/config_files/firefox_profile.zip
    rm -rf /home/vagrant/.mozilla
    mv ${TEMPD}/.mozilla /home/vagrant/.mozilla
    rm -rf ${TEMPD}
fi
