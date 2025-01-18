#!/bin/bash
MODDIR=${0%/*}
CONFIG_DIR="/data/adb/ntfy"
CONFIG_FILE="conf.sh"

source $CONFIG_DIR/$CONFIG_FILE
source $MODDIR/utils.sh

message=$(genDeviceEventMessageForAndroid "boot")

output=$(sendNtfyNotificationWithCurl "$message" "$custom_ntfy_server" "$ntfy_topic")

result=$?

while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done
while [ ! -d "/sdcard/Android" ]; do
    sleep 1
done

sleep 20

message=$(genDeviceEventMessageForAndroid "decrypted")

output=$(sendNtfyNotificationWithCurl "$message" "$custom_ntfy_server" "$ntfy_topic")

result=$?

cp $MODDIR/module.prop.origin $MODDIR/module.prop

sed -i '/description/d' $MODDIR/module.prop

# Check the command's return value
if [ $result -eq 0 ]; then
    echo "ntfy_at_boot: customize.sh - success ✅" >> /dev/kmsg
    echo "description=status: success ✅" >> "$MODDIR/module.prop"
else
    echo "description=status: failed 😭(output: $output)" >> "$MODDIR/module.prop"
fi
 
