Mozilla Integrated Tool Package
===============================

The Mozilla integrated tools package (MozITP) is a one-stop shop for setting up Firefox OS-related tools, which can handle automatic Testing on Mulet or a real device, [flashing TaskCluster images](https://pypi.python.org/pypi/b2g_util), flashing with the [B2G installer add-on](https://developer.mozilla.org/en-US/docs/Mozilla/Firefox_OS/Building_and_installing_Firefox_OS/B2G_installer_add-on), and running the TV and phone versions of Mulet.

# Environment setup

MozITP depends on **Vagrant** and **Virtualbox**.

By default, VM in VirtualBox will enable **VT-x/AMD-V** and **Nested Paging**, so you have to enable **VT-x/AMD-V** feature of your host.

Let's look at how to set up the environment on Linux, Mac OS X, and Windows.

## Ubuntu

* Download [Vagrant's Debian package](https://www.vagrantup.com/downloads.html).
* Install Vagrant using this: `sudo dpkg -i <PATH_TO_PKG_FILE>`
* Install VirtualBox using this: `sudo apt-get install virtualbox virtualbox-dkms virtualbox-qt`
* Reboot your computer after the Virtualbox installation has finished.
* Download and install the [VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads).
* [Set up the USB for VirtualBox](https://help.ubuntu.com/community/VirtualBox/USB) using the following command: `sudo adduser <USERNAME> vboxusers`
* Re-login or restart your computer.
* Make sure you enable Intel VT-x and VT-d in the BIOS.

## Mac OS X

* Install [Brew Cask](http://caskroom.io/).
* Install Vagrant using this: `sudo brew cask install vagrant; sudo brew cask install vagrant-manager`
* Install VirtualBox using this: `sudo brew cask install virtualbox`
* Install the VirtualBox Extension Pack using the following: `sudo brew cask install virtualbox-extension-pack`
* Make sure you enable Intel VT-x and VT-d in the BIOS.

## Windows (experimental)

* Install the [Windows version of Git](http://www.git-scm.com/download/win). Make sure that you don't let Git change the line ending symbol to windows format.
* Install the [Windows bash shell](http://win-bash.sourceforge.net/).
* Install [Vagrant for Windows](https://www.vagrantup.com/downloads.html).
* Install [Virtualbox for Windows](https://www.virtualbox.org/wiki/Downloads).
* Run `launch.sh` in PowerShell or git-bash
* Make sure you enable Intel VT-x and VT-d in the BIOS.
* If your VirtualBox VM failed to start, try enabling *Hyper-V* in *VirtualBox > Settings > System > Accleration > Paravirtualization Interface*.

## Other Platforms

Whatever the case, you need to install [Vagrant](https://docs.vagrantup.com/v2/installation/index.html) — see the [Installing Vagrant](https://docs.vagrantup.com/v2/installation/index.html) guide for more details.

You also need to install a VM [provider](https://docs.vagrantup.com/v2/providers/index.html) for Vagrant. We are assuming the use of [VirtualBox](http://www.virtualbox.org/) throughout our article.


# Cloning the Repo

After the environment has been set up, you need to clone the MozITP repo.

Do so with the following command:

``` bash
$ git clone https://github.com/mozilla-b2g/MozITP.git
```

And you can run `git pull` to get the latest version of this repo.


# Usage

Now you've set up the environment and cloned the repo, you can start using MozITP.

> **Note**: The following commands should be run from inside the *MozITP* directory.

## Setting permissions
If you get any problems running the scripts, you need to make sure you have the necessary permissions set on the commands. Add execute permissions, for example:

```bash
$ chmod u+x launch.sh
```

## Launching the MozITP
Launch MozITP with the following command:

```bash
$ ./launch.sh
```

At this point a Vagrant VM will be launched — you should see something like this:

![menu](https://raw.githubusercontent.com/Mozilla-TWQA/MozITP/master/menu.png)

## Stopping MozITP

To stop the VM, running the following:

```bash
$ ./bin/stop.sh
```

## Resetting to factory

To reset the VM to the factory defaults, run this command:

```bash
$ ./bin/reset_vm.sh
```

## Updating the VM

To update to the latest version of the VM, run the following:

```bash
$ ./bin/update_vm.sh
```

## GIJ (Gaia Integration Test / JS Marionette)

You can run the GIJ (Gaia integration tests in JavaScript) directly from inside MozITP, which is very useful for automation. See the **Supported Platforms** section for available targets.

> **Warning**: Sometimes the test case itself has bugs, which makes the GIJ test fail. To verify if it's a GIJ platform bug or a test case bug, run `./test/gij_phone_mulet_sanity_test.sh` or `./test/gij_phone_device_sanity_test.sh` files, depending on whether you are running the tests on Mulet or a real device. If it passes, it could be a bug in the test case, not the platform.

### Running GIJ

To run GIJ directly, run the following:

```bash
$ ./launch.sh gij
```

To run GIJ just on a specific app, you'll need a command structure like the following:

```bash
$ export APP=video; ./launch.sh gij # The `export` is important, don't miss it
```

To run GIJ on a specific test file:

```bash
$ export TEST_FILES=apps/clock/test/marionette/hour_format_test.js 
$ ./launch.sh gij
```

### Running GIJ directly on a device

To run GIJ directly on the device. The device must be connected through USB before you run the command:

```bash
$ ./launch.sh gij device
```

### Running GIJ with your own Gaia build

If you already have a Gaia repository you want to test, you can use the following commands:

```bash
$ export GAIA=/path/to/your/gaia
$ ./launch.sh
```

If you change your mind and want to use the latest Gaia instead, you can do this:

```bash
$ ./reset_vm.sh
$ unset GAIA
$ ./launch.sh
```

Or if you want to keep the VM, you can do this:

```bash
$ unset GAIA
$ ./launch.sh
$ vagrant ssh -c "rm ~/.users_gaia_exists" # Remove the flag
$ ./bin/stop.sh # Restart the VM
$ ./launch.sh
```

## GIP (Python Gaia Integration Test)

See **Supported Platforms** section for available targets.

### Running GIP

To run GIP, do the following:

```bash
$ ./launch.sh gip 
```

## Flashing

Let's look at how to flash a TaskCluster image onto your instance of MozITP.

If you already have TaskCluster credentials:

* For flashing the TaskCluster image (needs credentials), please run `./bin/get_credentials.sh` before flashing. 
* Next, run `./launch.sh` and select *Flashing B2G Image*.
* Or just run `./launch.sh flash`.

If you don't have TaskCluster credentials:

* You can use the B2G installer add-on to handle this.
* Run `./launch.sh` and select *Enter Firefox b2g-installer Add-on* from the menu.


## Shared Folder

You can put files/folders into **shared** folder.

* The **shared** folder will be pushed from host into VM when you run `./launch.sh`.
* The **shared** folder will be pulled from VM to host when you exit the `./launch.sh` script, or when run `./bin/stop.sh`.

The following table contains a summary of the commands:

| Command             | From | To   |
|---------------------|------|------|
| run `./launch.sh`   | host | VM   |
| exit `./launch.sh`  | VM   | host |
| run `./bin/stop.sh` | VM   | host |


# Troubleshooting
* To run `launch.sh` in jenkins or over SSH, use `xvfb-run ./launch.sh`, otherwise the `vagrant up` command will fail.
* To run tests on a device connected via USB device, you need to first add the user to the vboxusers group using the following command structure:

```bash
$ sudo adduser <your username> vboxusers
```
* If you want to run tests against USB-connected devices in Jenkins, also add the *jenkins* user to the *vboxusers* group.

# Supported Platforms

The following platforms are supported by MozITP:

* Linux
* OS X
* Windows (experimental)
* Flashable devices: Aries (Sony Z3C), Flame

The following table shows the different environments that can be tested/emulated by MozITP, and how well specific tests currently work on those environments:

| Platform       | GIJ          |  GIP  | Fuzz    | 
|----------------|--------------|-------|---------|
| Phone Mulet    | OK (headless)| OK    | 2015 Q1 |
| Phone Device   | OK           | OK    | OK      |
| Phone Emulator | Too slow     | by request* | by request* | 
| TV Mulet       | 2015 Q1      | by request* | by request* |
| TV Device      | by request*  | by request* | by request* |
| TV Emulator    | by request*  | by request* | by request* |

\* This combination doesn't currently work. If you need it/want to help with getting it running, please file a bug or email us.

# See Also

* [MDN](https://developer.mozilla.org/en-US/docs/Mozilla/Firefox_OS/Automated_testing/MozITP)
* [Wiki](https://wiki.mozilla.org/B2G/MozITP)
