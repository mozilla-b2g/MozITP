if [ $(adb get-state) != "device" ];
then 
  echo "+============================================+"
  echo "| You need to connect your device right now. |"
  echo "| Please plug the device in and try again.   |"
  echo "+============================================+"
  exit 
fi

SCRIPT_PATH="`dirname \"$0\"`"

export BUILDAPP=device
$SCRIPT_PATH/gij.sh
