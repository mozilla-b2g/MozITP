Mozilla Integrated Tool Package
================================
This package is a one-stop shop for Firefox OS related tools

#Installation 
You need to install [Vagrant](https://docs.vagrantup.com/v2/installation/index.html), follow this [guide](https://docs.vagrantup.com/v2/installation/index.html)

#Usage
```
chmod u+x launch.sh
launch.sh
```
A Vagrant VM will be launched

* Stop the VM

```
cd vm
vagrant halt
```

* Reset the VM to factory default

```
cd vm
vagrant destroy # answer yes if asked
```
