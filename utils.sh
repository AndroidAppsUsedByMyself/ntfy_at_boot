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
	local custom_ntfy_server="${2:-https://ntfy.sh}"
	local ntfy_topic="$3"
	local output

	output=$(curl \
		-X POST \
		-d "$message" \
		"${custom_ntfy_server}/${ntfy_topic}" 2>&1)
	result=$?
	echo "$output"
	return $result
}

sendNtfyNotificationWithCurlWithAllArgsV1() {
    title="$1"
    priority="$2"
    tags="$3"
    message="$4"
    email="$5"
    attach="$6"
    url="$7"
    output=""
    curl_args=""

    if [ "$title" != "none" ]; then
        curl_args="$curl_args -H 'Title:$title'"
    fi

    if [ "$priority" != "none" ]; then
        curl_args="$curl_args -H 'Priority:$priority'"
    fi

    if [ "$tags" != "none" ]; then
        curl_args="$curl_args -H 'Tags:$tags'"
    fi

    if [ "$email" != "none" ]; then
        curl_args="$curl_args -H 'Email:$email'"
    fi

    if [ "$attach" != "none" ]; then
        curl_args="$curl_args -H 'Attach:$attach'"
    fi

	curl_command="curl -X POST $url $curl_args"

	output=$($curl_command -d "$message" 2>&1)
    result=$?

    # 输出 curl 的结果
    echo "$output"
    return $result
}

# sendNtfyNotificationWithCurlWithAllArgsV0() {
# 	local title="$1"
# 	local priority="$2"
# 	local tags="$3"
# 	local message="$4"
# 	local url="$5"
# 	local email="$6"
# 	local attach="$7"
# 	local output
# 	local curl_args=()

# 	# 构建 curl 命令参数
# 	if [[ "$title" != "none" ]]; then
# 		curl_args+=("-H" "Title: $title")
# 	fi

# 	if [[ "$priority" != "none" ]]; then
# 		curl_args+=("-H" "Priority: $priority")
# 	fi

# 	if [[ "$tags" != "none" ]]; then
# 		curl_args+=("-H" "Tags: $tags")
# 	fi

# 	if [[ "$email" != "none" ]]; then
# 		curl_args+=("-H" "Email: $email")
# 	fi

# 	if [[ "$attach" != "none" ]]; then
# 		curl_args+=("-H" "Attach: $attach")
# 	fi

# 	# 添加消息体和 URL
# 	curl_args+=("-d" "$message")
# 	curl_args+=("$url")

# 	# 执行 curl 命令
# 	output=$(curl -X POST "${curl_args[@]}" 2>&1)
# 	result=$?

# 	# 输出 curl 的结果
# 	echo "$output"
# 	return $result
# }

sendNtfyNotificationWithNtfyCli() {
	local message="$1"
	local ntfy_topic="$2"
	local custom_ntfy_server="${3:-https://ntfy.sh}"
	local binary="$4"
	local output
	output=$($binary publish $ntfy_topic $message)
	result=$?
	echo "$output"
	return $result
}
