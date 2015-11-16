THIS_REPO_URL=$(git config --get remote.origin.url | sed 's/git@github.com:/https:\/\/github.com\//g' )
cd vm
vagrant up
VM_SHELL="vagrant ssh -c"

$VM_SHELL "cat | bash /dev/stdin $THIS_REPO_URL" < ../scripts/provision.sh  

case $1 in 
  gij)
    case $2 in 
      simulator)
        $VM_SHELL "bash ~/MozITP/scripts/gij.sh"
        ;;
      emulator)
        echo "Not supported yet"
        ;;
      device)
        $VM_SHELL "bash ~/MozITP/scripts/install_adb_fastboot.sh"
        echo "Not supported yet"
        ;;
      *)
        $VM_SHELL "bash ~/MozITP/scripts/install_adb_fastboot.sh"
        $VM_SHELL "bash ~/MozITP/scripts/gij.sh"
        ;;
    esac
    ;;
  flashtool)
    # Install Android's tools: adb and fastboot
    $VM_SHELL "bash ~/MozITP/scripts/install_adb_fastboot.sh"

    # Install B2G and Taskcluster tools
    $VM_SHELL "bash ~/MozITP/scripts/install_b2g_and_tc_tools.sh"
    ;;
  *)
    $VM_SHELL "cd ./MozITP/scripts/; ./menu.sh"
    ;;
esac


# start
# $VM_SHELL "bash ~/MozITP/scripts/startgui.sh"
# $VM_SHELL "cd ./MozITP/scripts/; ./menu.sh"
