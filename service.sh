MODDIR=${0%/*}
CONFIG_DIR="/data/adb/ntfy"
CONFIG_FILE="conf.sh"

source "$CONFIG_DIR/$CONFIG_FILE"
source "$MODDIR/utils.sh"

message=$(genDeviceEventMessageForAndroid "boot")

for NTFY_SUBSCRIPTION in $NTFY_SUBSCRIPTIONS; do
    output=$(sendNtfyNotificationWithCurlWithAllArgsV1 "Android" "default" "none" "$message" "none" "none" "$NTFY_SUBSCRIPTION")
    result=$?

    echo "Subscription: $NTFY_SUBSCRIPTION - Result:$result - Output: $output"
    ui_print "Subscription: $NTFY_SUBSCRIPTION - Result:$result - Output: $output"
    echo "Subscription: $NTFY_SUBSCRIPTION - Result:$result - Output: $output" >> /dev/kmsg
done

while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done
while [ ! -d "/sdcard/Android" ]; do
    sleep 1
done

sleep 20

message=$(genDeviceEventMessageForAndroid "decrypted")

for NTFY_SUBSCRIPTION in $NTFY_SUBSCRIPTIONS; do
    output=$(sendNtfyNotificationWithCurlWithAllArgsV1 "Android" "default" "none" "$message" "none" "none" "$NTFY_SUBSCRIPTION")
    result=$?

    ui_print "Subscription: $NTFY_SUBSCRIPTION - Result:$result - Output: $output"
    echo "Subscription: $NTFY_SUBSCRIPTION - Result:$result - Output: $output" >> /dev/kmsg
done

cp "$MODDIR/module.prop.origin" "$MODDIR/module.prop"

sed -i '/description/d' "$MODDIR/module.prop"

echo "description=status: success ✅" >> "$MODDIR/module.prop"