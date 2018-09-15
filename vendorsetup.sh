for combo in $(curl -s https://raw.githubusercontent.com/ViperOS/hudson/master/viper-build-targets | sed -e 's/#.*$//' | grep viper-15.1 | awk '{printf "viper_%s-%s\n", $1, $2}')
do
    add_lunch_combo $combo
done
