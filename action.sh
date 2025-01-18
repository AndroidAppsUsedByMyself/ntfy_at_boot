#!/bin/bash
MODDIR=${0%/*}
#MODDIR="/data/adb/modules/ntfy_at_boot"
CONFIG_DIR="/data/adb/ntfy"
CONFIG_FILE="conf.sh"

source "$CONFIG_DIR/$CONFIG_FILE"
source $MODDIR/utils.sh

message=$(genDeviceEventMessageForAndroid "action")

output=$(sendNtfyNotificationWithCurl "$message" "$custom_ntfy_server" "$ntfy_topic")

result=$?

ui_print "- raw output: $output"

sed -i '/description/d' $MODDIR/module.prop

# Check the command's return value
if [ $result -eq 0 ]; then
    echo "ntfy_at_boot: customize.sh - success ✅" >> /dev/kmsg
    echo "
description=status: success ✅
" >> "$MODDIR/module.prop"
else
    echo "
description=status: failed 😭
(output: $output)
" >> "$MODDIR/module.prop"
fi
