MODDIR=${0%/*}
#MODDIR="/data/adb/modules/ntfy_at_boot"
CONFIG_DIR="/data/adb/ntfy"
CONFIG_FILE="conf.sh"

source "$CONFIG_DIR/$CONFIG_FILE"
source $MODDIR/utils.sh

message=$(genDeviceEventMessageForAndroid "action")

outputs=""

for NTFY_SUBSCRIPTION in $NTFY_SUBSCRIPTIONS; do
    output=$(sendNtfyNotificationWithCurlWithAllArgsV1 "Android" "default" "none" "$message" "none" "none" "$NTFY_SUBSCRIPTION")
    result=$?

    outputs="${outputs}Subscription:$NTFY_SUBSCRIPTION - Result:$result - Output:$output
"
done

while IFS= read -r output; do
    ui_print "$output"
    echo "$output" >> /dev/kmsg
done <<< "$outputs"

cp $MODDIR/module.prop.origin $MODDIR/module.prop

sed -i '/description=/d' $MODDIR/module.prop

echo "$outputs" >> /dev/kmsg
echo "description=status: success ✅" >> "$MODDIR/module.prop"