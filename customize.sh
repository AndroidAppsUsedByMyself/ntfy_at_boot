MODDIR="${0%/*}"
CONFIG_DIR="/data/adb/ntfy"
CONFIG_FILE="conf.sh"
if [ ! -d "/data/adb/ntfy" ]; then
  mkdir -p $CONFIG_DIR
  set_perm $CONFIG_DIR 0 0 0755
fi

if [ ! -f $CONFIG_DIR/$CONFIG_FILE ]; then
  cp -f $MODPATH/conf.sh $CONFIG_DIR/$CONFIG_FILE
fi

source $CONFIG_DIR/$CONFIG_FILE
source $MODPATH/utils.sh
ui_print "- installing ntfy_at_boot"

# Check if ntfy_topic is the placeholder "<ntfy_topic>"
if [ "$ntfy_topic" = "<ntfy_topic>" ]; then
    ui_print "Please modify the 'conf.sh' to set a valid ntfy_topic."
else
    message=$(genDeviceEventMessageForAndroid "install")
    output=$(sendNtfyNotificationWithCurl "$message" "$custom_ntfy_server" "$ntfy_topic")
    result=$?

    ui_print "- raw output: 
$output"

    # Check the command's return value
    if [ $result -eq 0 ]; then
        echo "ntfy_at_boot: customize.sh - success ✅" >> /dev/kmsg
        ui_print "- status: success ✅"
    else
        ui_print "- status: failed 😭 needs correction 💢
    output: $output"
    fi
fi
