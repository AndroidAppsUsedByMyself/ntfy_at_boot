getModelForAndroid() {
	model=$(getprop ro.product.model)
	echo $model
}

getDeviceForAndroid() {
	device=$(getprop ro.product.device)
	echo $device
}

getSystemForAndroid() {
	system=$(getprop ro.build.version.release)
	echo "Android $system"
}

getTimeForLinux() {
	time=$(date +%Y-%m-%dT%H:%M:%S%Z)
	echo "$time"
}

genDeviceEventMessageForAndroid() {
	local model=$(getModelForAndroid)
	local device=$(getDeviceForAndroid)
	local system=$(getSystemForAndroid)
	local time=$(getTimeForLinux)
	local status="$1"
	local message="Android[$model($device)][$system] $status at $time"
	echo $message
}

sendNtfyNotificationWithCurl() {
	local message="$1"
	local custom_ntfy_server="$2"
	local ntfy_topic="$3"
	local output

	output=$(curl \
		-X POST \
		-d "$message" \
		"$custom_ntfy_server/$ntfy_topic" 2>&1)
	result=$?
	echo "$output"
	return $result
}

sendNtfyNotificationWithNtfyCli() {
	local message="$1"
	local ntfy_topic="$2"
	local custom_ntfy_server="$3"
	local binary="$4"
	local output
	output=$($binary publish $ntfy_topic $message)
	result=$?
	echo "$output"
	return $result
}
