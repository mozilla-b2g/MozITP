Mozilla Integrated Tool Package
===============================

This package is a one-stop shop for Firefox OS related tools

# Installation 
MozITP depends on Vagrant and Virtualbox.

By default, VM in VirtualBox will enable `VT-x/AMD-V` and `Nested Paging`, so you should enable `VT-x/AMD-V` feature of your host.

## Ubuntu

* Download Vagrant's Debian package from [here](https://www.vagrantup.com/downloads.html).
* Install Vagrant by `sudo dpkg -i <PATH_TO_PKG_FILE>`
* Install VirtualBox by `sudo apt-get install virtualbox virtualbox-dkms virtualbox-qt`
* Reboot your computer after virutalbox installation finished
* Download and install VirtualBox Extension Pack from [here](https://www.virtualbox.org/wiki/Downloads).
* Then [set up USB for VirtualBox](https://help.ubuntu.com/community/VirtualBox/USB) by `sudo adduser <USERNAME> vboxusers`
* Re-login or restart your PC.
* Make sure you enable Intel VT-x and VT-d in BIOS.

## Mac OS X

* Install [Brew Cask](http://caskroom.io/).
* Install Vagrant by `sudo brew cask install vagrant; sudo brew cask install vagrant-manager`
* Install VirtualBox by `sudo brew cask install virtualbox`
* Install VirtualBox Extension Pack by `sudo brew cask install virtualbox-extension-pack`
* Make sure you enable Intel VT-x and VT-d in BIOS.

## Windows (experimental) 
* Install the Windows version of git
   * Install the bash shell
   * Do not let git change the line ending symbol to windows format
* Install Vagrant for Windows
* Install Virtualbox for Windows
* Run `launch.sh` in PowerShell or git-bash
* Make sure you enable Intel VT-x and VT-d in BIOS.
* If your VirtualBox VM failed to start, try enabling "Hyper-V" in VirtualBox > Settings > System > Accleration > Paravirtualization Interface.

## Other Platforms
You need to install [Vagrant](https://docs.vagrantup.com/v2/installation/index.html), see more detail from this [guide](https://docs.vagrantup.com/v2/installation/index.html).

And you also need to install the [provider](https://docs.vagrantup.com/v2/providers/index.html) for Vagrant. We will use [VirtualBox](http://www.virtualbox.org/) as default.


# Cloning the Repo
Run following command for cloning this repo.
```
git clone <this repo's URL>
```

And you can run `git pull` to get the latest version of this repo.


# Usage
## Start/Stop the VM
* Add execute permissions

```bash
$ chmod u+x launch.sh
```

* Launch VM

```bash
$ ./launch.sh
```

A Vagrant VM will be launched.

You should see something like this:

![menu](https://raw.githubusercontent.com/Mozilla-TWQA/MozITP/master/menu.png)

* Stop the VM

```bash
$ ./bin/stop.sh
```

* Reset the VM to factory default

```bash
$ ./bin/reset_vm.sh
```

* Update the VM

```bash
$ ./bin/update_vm.sh
```


## GIJ
See Supported Platforms section for available targets.

* Run GIJ (Gaia integration test in JavaScript) directly. This is very useful in automation.

> Warning: sometimes the test case itself has bugs, which makes the GIJ test fail. To verify if it's a GIJ platform bug or a test case bug, run `./test/gij_phone_mulet_sanity_test.sh`. If it passes, it could be a bug in the test case, not the platform.

```bash
$ ./launch.sh gij
```

* Run GIJ on a specific app 

```bash
$ export APP=video; ./launch.sh gij # The `export` is important, don't miss it
```

* Run GIJ on a specific test file

```bash
export TEST_FILES=apps/clock/test/marionette/hour_format_test.js 
./launch.sh gij
```

* Run GIJ on device directly. The device must be connected through USB before you run the command

> Warning: sometimes the test case itself has bugs, which makes the GIJ test fail. To verify if it's a GIJ platform bug or a test case bug, run `./test/gij_phone_device_sanity_test.sh`. If it passes, it could be a bug in the test case, not the platform.

```bash
$ ./launch.sh gij device
```

* Using your own gaia repository
If you already have a gaia repository, use the following commands:

```bash
export GAIA=/path/to/your/gaia
./launch.sh
```

If you change your mind and want to use the latest gaia instead, you can 
```
./reset_vm.sh
unset GAIA
./launch.sh
```

Or if you want to keep the VM, you can
```
unset GAIA
./launch.sh

# Remove the flag
vagrant ssh -c "rm ~/.users_gaia_exists"

# Restart the VM
./bin/stop.sh
./launch.sh
```

## GIP
See Supported Platforms section for available targets.

```
./launch.sh gip 
```

## Flashing
* Have TaskCluster credentials

For flashing the TaskCluster image (need credentials), please run `./bin/get_credentials.sh` before flashing.

Then run `launch.sh` and select `Flashing B2G Image`, or just run `./launch.sh flash`.

* Do not have TaskCluster credentials

You can use the B2G Installer Add-on, run `./launch.sh` and select `Enter Firefox b2g-installer Add-on` from the menu.


## Shared Folder

You can put files/folders into `shared` folder.

The `shared` folder will be pushed from host into VM when you run `./launch.sh`.

And the `shared` folder will be pulled from VM to host when you run `./bin/stop.sh`.


# Troubleshooting
* To run `launch.sh` in jenkins or over SSH, use `xvfb-run ./launch.sh`, otherwise the `vagrant up` command will fail.
* To use the USB device, add the user to the `vboxusers` group. 

```
sudo adduser <your username> vboxusers
```
* If you want to run USB device test in Jenkins, also add the `jenkins` user to the `vboxusers` group

# Supported Platforms
* Linux
* OS X
* Windows (experimental)
* Flashable devices: Aries (Sony Z3C), Flame

| Platform       | GIJ          |  GIP  | Fuzz    | 
|----------------|--------------|-------|---------|
| Phone Mulet    | OK (headless)| OK    | 2015 Q1 |
| Phone Device   | OK           | OK    | OK      |
| Phone Emulator | Too slow     | by request | by request | 
| TV Mulet       | 2015 Q1      | by request | by request |
| TV Device      | by request   | by request | by request |
| TV Emulator    | by request   | by request | by request |

by request: If you need this comination, please open an issue or email us.


