# TODO: get filename
SCRIPT_PATH="`dirname \"$0\"`"

ZIP_FILENAME="`basename $1`"
UNZIPPED_DIR="output/`basename $1 | cut -d_ -f1`"

cd ~/fuzz

echo "Cleaning up $UNZIPPED_DIR"
rm -rf $UNZIPPED_DIR
echo "Unzipping $ZIP_FILENAME"
unzip -o $ZIP_FILENAME

cd $UNZIPPED_DIR

source $SCRIPT_PATH/gip_provision.sh

# TODO: read the launch script path from the config
cd ~/fuzz/$UNZIPPED_DIR

source ~/gaia/venv_gip/bin/activate # start the virtual env
bash ./launch.sh

