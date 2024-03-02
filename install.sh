#!/bin/env bash Function to log messages to stderr and a log file log() {
	local message="$1"
	local log_file="/var/log/$(date +"%Y-%m-%d_%T")-install-security-updates-util.log"

	echo "$(date +"%Y-%m-%d %T"): $message" >&2
	echo "$(date +"%Y-%m-%d %T"): $message" >> "$log_file"

}

# Function to handle errors
error() {
	echo "$(date +"%Y-%m-%d %T"): Error: $1" >&2
	log "Error: $1" >&2

	exit 1
}

# Function to copy files and handle errors
copy() {
	sudo cp "$1" "$2" || { 
		error "Failed to copy $1 to $2"
	}
}

# Function to start systemd service and handle errors
start() {
	sudo systemctl start "$1" || { 
		error "Failed to start $1 service"
	}
	sudo systemctl enable "$1" || { 
		error "Failed to enable $1 service"
	}
}

# Check if the script is running as root
if [[ $EUID -ne 0 ]]; then

	log "Error: This script must be run as root."

	exit 1

fi

# Check if security-updates.sh exists in /root/
if [[ ! -f /root/security-updates.sh ]]; then
	copy "security-updates.sh" "/root/"
	echo "security-updates.sh has been copied to /root/"
else
	echo "security-updates.sh already exists in /root/"
fi
echo "security-updates.sh lives at /root/security-updates.sh"

# Check if myupdater.service exists in systemd directory
if [[ ! -f "/etc/systemd/system/myupdater.service" ]]; then
	copy "myupdater.service" "/etc/systemd/system/"
	start "myupdater.service"
	echo "myupdater.service installed and started successfully on $(hostname)."
else
	echo "myupdater.service already installed on $(hostname)."
fi
