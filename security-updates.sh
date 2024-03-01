#!/bin/bash

while true; do
    # Download and install only security updates without changing config files
    apt update
    apt upgrade --without-new-pkgs --no-install-recommends -y

    # Schedule reboot at 00:00 the next day
    #echo "0 0 * * * reboot" | crontab -

    # Sleep for 14 days before checking for updates again
    sleep 1209600
done
