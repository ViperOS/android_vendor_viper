for device in $(cat vendor/viper/viper.devices)
do
add_lunch_combo viper_$device-userdebug
done