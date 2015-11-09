Mozilla Integrated Tool Package
===============================

This package is a one-stop shop for Firefox OS related tools

# Installation 

You need to install [Vagrant](https://docs.vagrantup.com/v2/installation/index.html), see more detail from this [guide](https://docs.vagrantup.com/v2/installation/index.html).

And you also need to install the [provider](https://docs.vagrantup.com/v2/providers/index.html) for Vagrant. We will use [VirtualBox](http://www.virtualbox.org/) as default.

## Ubuntu
* Download Vagrant's Debian package from [here](http://www.vagrantup.com/downloads).
* Install Vagrant by `sudo dpkg -i <PATH_TO_PKG_FILE>`
* Install VirtualBox by `sudo apt-get install virtualbox`

Then [set up USB for VirtualBox](https://help.ubuntu.com/community/VirtualBox/USB) by adding your user account to vboxusers group. 
* Run `sudo adduser <USERNAME> vboxusers`
* Re-login or restart your PC.

## Mac OS X
* Install [Brew Cask](http://caskroom.io/).
* Install Vagrant by `sudo brew cask vagrant; sudo brew cask vagrant-manager`
* Install VirtualBox by `sudo brew cask virtualbox`


# Usage

* Add execute permissions

```bash
$ chmod u+x launch.sh
$ chmod u+x stop.sh
```

* Launch VM

```bash
$ ./launch.sh
```

A Vagrant VM will be launched.


* Stop the VM

```bash
$ ./stop.sh
```

* Reset the VM to factory default

```bash
$ ./reset_vm.sh
```
