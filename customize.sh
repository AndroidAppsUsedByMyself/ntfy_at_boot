MODDIR="${0%/*}"
CONFIG_DIR="/data/adb/ntfy"
CONFIG_FILE="conf.sh"
if [ ! -d "/data/adb/ntfy" ]; then
  mkdir -p $CONFIG_DIR
  set_perm $CONFIG_DIR 0 0 0755
fi

if [ ! -f $CONFIG_DIR/$CONFIG_FILE ]; then
  cp -f $MODPATH/conf.sh $CONFIG_DIR/$CONFIG_FILE
  message=$(genDeviceEventMessageForAndroid "install")
fi

cp -f $MODPATH/module.prop $MODPATH/module.prop.origin

source $CONFIG_DIR/$CONFIG_FILE
source $MODPATH/utils.sh
ui_print "- installing ntfy_at_boot"

# Check if NTFY_SUBSCRIPTIONS is the placeholder "https://ntfy.sh/test https://ntfy.sh/test2"
if [ "$NTFY_SUBSCRIPTIONS" = "https://ntfy.sh/test https://ntfy.sh/test2" ]; then
    ui_print "Please modify the 'conf.sh' to set a valid ntfy_topic."
else
    message=$(genDeviceEventMessageForAndroid "update")
fi

outputs=""

for NTFY_SUBSCRIPTION in $NTFY_SUBSCRIPTIONS; do
    output=$(sendNtfyNotificationWithCurlWithAllArgsV1 "Android" "default" "none" "$message" "none" "none" "$NTFY_SUBSCRIPTION")
    result=$?

    outputs="$outputs Subscription:$NTFY_SUBSCRIPTION - Result: $result - Output:$output"$'\n'
done

echo "$outputs" | while IFS= read -r output; do
    ui_print "$output"
    echo "$output" >> /dev/kmsg
done