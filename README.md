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
* Then [set up USB for VirtualBox](https://help.ubuntu.com/community/VirtualBox/USB) by `sudo adduser <USERNAME> vboxusers`
* Re-login or restart your PC.

## Mac OS X

* Install [Brew Cask](http://caskroom.io/).
* Install Vagrant by `sudo brew cask vagrant; sudo brew cask vagrant-manager`
* Install VirtualBox by `sudo brew cask virtualbox`

# Cloning the Repo
Use `git clone` with ``--recursive`` so the `vm/` submodule are cloned too.
```
git clone --recursive <this repo's URL>
```

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

* Run GIJ (Gaia integration test in JavaScript) directly. This is very useful in automation.
```bash
$ ./launch.sh gij
```


#Troubleshooting
* To run `launch.sh` in jenkins, use `xvfb-run`.
