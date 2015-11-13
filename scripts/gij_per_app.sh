apps=($(ls ~/gaia/apps))

for app in ${apps[@]}; do
    APP=$app ./gij.sh
done
