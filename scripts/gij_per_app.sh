apps=($(ls ~/gaia/apps))

for app in ${apps[@]}; do
    APP=$app ./gij_phone_mulet.sh
done
