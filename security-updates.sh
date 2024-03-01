#!/bin/bash

while true; do
    # Download and install only security updates
    apt-get update && apt-get -y -t $(lsb_release -cs)-security upgrade

    # Schedule reboot at 00:00 the next day
    #echo "0 0 * * * reboot" | crontab -

    # Sleep for 24 hours before checking for updates again
    sleep 86400
done
