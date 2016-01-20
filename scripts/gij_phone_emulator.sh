mkdir ~/emulator
pushd ~/emulator

# Download and extract
# x86 version
# taskcluster_download -n gecko.v2.mozilla-central.latest.b2g.emulator-x86-kk-debug -a public/build/emulator.tar.gz
taskcluster_download -n gecko.v2.mozilla-central.latest.b2g.emulator-kk-debug -a public/build/emulator.tar.gz
tar zxvf emulator.tar.gz # will generate b2g-distro/

pushd b2g-distro/

# Install dependencies
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libc6:i386 \
                     libncurses5:i386 \
                     libstdc++6:i386 \
                     libsdl1.2debian:i386 \
                     libgl1-mesa-glx:i386 \
                     libgl1-mesa-dev:i386


# Start emulator
chmod u+x out/host/linux-x86/bin/

xvfb-run ./run-emulator.sh &


#Start GIJ
pushd ~/gaia

# Remember to set the TEST_FILES or APP
export BUILD_APP=device
make test-integration-test #The emulator will be too slow for GIJ to run

popd # gaia
popd # b2g-distro
popd # emulator
 
