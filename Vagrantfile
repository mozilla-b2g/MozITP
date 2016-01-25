# -*- mode: ruby -*-
# vi: set ft=ruby :

# Credit: Thanks to Fred Lin's FoxBox project
#
# To use this script and prepare your build environment, run the following
# command in the same directory as the Vagrantfile.
# B2G_PATH={path to your B2G directory} vagrant up

VAGRANTFILE_API_VERSION = "2"

# This script will be run on the first start and it will set up the build
# environment.
# All you need to do afterwards is:
# * vagrant ssh
# * Unplug/Plug the phone; run `adb devices` to make sure that the phone is
# listed.
# * cd B2G
# * ./configure.sh {your device}
# * ./build.sh

# $bootstrap = <<SCRIPT
#SCRIPT

#
# Vagrant script
#
# Detect if B2G_PATH is exist
# if (defined?(ENV['B2G_PATH'])).nil?
#   B2G_PATH = nil
# else
#   B2G_PATH = ENV['B2G_PATH']
# end
# 
# # Detect if GECKO_PATH is exist
# if (defined?(ENV['GECKO_PATH'])).nil?
#   GECKO_PATH = nil
# else
#   GECKO_PATH = ENV['GECKO_PATH']
# end
# 
# # Detect if GAIA_PATH is exist
# if (defined?(ENV['GAIA_PATH'])).nil?
#   GAIA_PATH = nil
# else
#   GAIA_PATH = ENV['GAIA_PATH']
# end

# Detect platform
def is_windows
  processor, platform, *rest = RUBY_PLATFORM.split("-")
  platform === 'mingw32'
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Use ubuntu 14.04
  #config.vm.box = "ubuntu/trusty64" # must use 64 because mozilla-download needs to download
  config.vm.box = "shinglyu/MozITP" # must use 64 because mozilla-download needs to download
  #config.vm.box = "MozITP" # must use 64 because mozilla-download needs to download
  #config.vm.box_url = "file:///tmp/mozitp_da52fd4.box" # must use 64 because mozilla-download needs to download
  # linux64-mulet. There is no linux-mulet for 32 bit machine

  #config.ssh.insert_key = false

  # Run the bootsrap script on start.
  # config.vm.provision "shell", inline: $bootstrap
  # config.vm.provision "shell", path: "scripts/setup_ubuntu_14_04.sh"
  # config.vm.provision "shell", path: "scripts/startup.sh", run: "always", privileged: false

  # Assign static IP to be able to use nfs option (if you have a conflict,
  # change it to something else).
  # Configure as host-only ip
  config.vm.network "private_network", ip: "192.168.50.4"
  # Configure as public DHCP, to make repo sync works
  #config.vm.network "public_network"
  # Configure as DHCP with default bridge
  # config.vm.network "public_network", :bridge => 'en0: Wi-Fi (AirPort)'
  config.vm.network "forwarded_port", guest: 9000, host:9000

  # Use *_PATH environment variable to sync with vm's /home/vagrant/*
  # directory.

  # Windows guide:
  # remember install winnfsd on windows
  # $vagrant plugin install vagrant-winnfsd
  # and replace GAIA_PATH such as "C:\\Users\\lin\\Documents\\GitHub\\foxbox\\gaia" on windows

  # if (B2G_PATH != nil)
  #   config.vm.synced_folder B2G_PATH, "/home/vagrant/B2G", type: "nfs"
  # end
  # if (GECKO_PATH != nil)
  #   config.vm.synced_folder GECKO_PATH, "/home/vagrant/gecko", type: "nfs"
  # end
  # #if (GAIA_PATH != nil)
  #   config.vm.synced_folder GAIA_PATH, "/home/vagrant/gaia", type: "nfs"
  # #end

  # The following folder will push into guest when vagrant up.
  config.vm.synced_folder "./shared", "/home/vagrant/MozITP/shared", type: "rsync", rsync__exclude: ".git/"
  config.vm.synced_folder "./config_files", "/home/vagrant/MozITP/config_files", type: "rsync", rsync__exclude: ".git/"
  config.vm.synced_folder "./scripts", "/home/vagrant/MozITP/scripts", type: "rsync", rsync__exclude: ".git/"
  config.vm.synced_folder "./util", "/home/vagrant/MozITP/util", type: "rsync", rsync__exclude: ".git/"

  # define the method for checking the usbfilter by VBoxMange showvminfo
  def usbfilter_exists(vendorid, productid)
    path_vagrant_id = ".vagrant/machines/default/virtualbox/id"
    # vm doesn't exist
    if not File.exists? path_vagrant_id
      return false
    end
    # get the vm info
    vm_info = `VBoxManage showvminfo $(<#{path_vagrant_id})`
    filter_match = "VendorId:         #{vendorid}\nProductId:        #{productid}\n"
    return vm_info.include? filter_match
  end

  # define the method for add usbfilter
  def add_usbfilter(v, name, vendorid, productid)
    # add the usbfilter with the specified filter name, vendorId and productId.
    if not usbfilter_exists(vendorid, productid)
      v.customize ['usbfilter', 'add', '0', '--target', :id, '--name', name, '--vendorid', vendorid, '--productid', productid]
    end
  end

  # config vm
  config.vm.provider "virtualbox" do |v|
    # Enable GUI
    v.gui = true
    # Enable 4GB of RAM
    v.customize ["modifyvm", :id, "--memory", "4096"]
    # Enable usb
    v.customize ["modifyvm", :id, "--usb", "on"]
    # Filter the devices
    # ref: http://developer.android.com/tools/device.html#VendorIds
    add_usbfilter(v, 'Google', '18d1', '')
    add_usbfilter(v, 'Foxconn', '0489', '')
    add_usbfilter(v, 'Google', '18d1', '')
    add_usbfilter(v, 'Huawei', '12d1', '')
    add_usbfilter(v, 'LG', '1004', '')
    add_usbfilter(v, 'Qualcomm', '05c6', '')
    add_usbfilter(v, 'Sony', '0fce', '')
    add_usbfilter(v, 'Spreadtrum', '1782', '')
    add_usbfilter(v, 'ZTE', '19d2', '')
  end

end
