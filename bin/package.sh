# Remember to run vagrant box remove MozITP before you repackage
OUTPUT=/tmp/mozitp_$(git rev-parse --short HEAD).box

# Need to be run in the root dir
./bin/reset_vm.sh
./bin/gij_sanity_test.sh
# ./bin/gip_sanity_test.sh
# TODO: b2g-installer + X-window
#DEBUG
#vagrant ssh -c "sudo bash ~/MozITP/scripts/package/cleanup.sh"
vagrant package --output $OUTPUT
ls -lh $OUTPUT
