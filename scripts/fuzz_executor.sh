# TODO: get filename
SCRIPT_PATH="`dirname \"$0\"`"

ZIP_FILENAME=generator.zip
UNZIPPED_DIR=output
cd ~/fuzz
unzip -o $ZIP_FILENAME

cd $UNZIPPED_DIR

source $SCRIPT_PATH/gip_provision.sh

# TODO: read the launch script path from the config
cd ~/fuzz/$UNZIPPED_DIR

source ~/gaia/venv_gip/bin/activate # start the virtual env
bash ./launch.sh

