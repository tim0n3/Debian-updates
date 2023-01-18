#!/bin/bash

# Check if the security-updates.sh file exists in the /root/ directory
if [ ! -f /root/security-updates.sh ]; then
  # Copy the security-updates.sh file from the current directory to /root/
  cp security-updates.sh /root/
  # Confirm that the file has been copied successfully
  if [ $? -eq 0 ]; then
    echo "security-updates.sh has been copied to /root/"
  else
    echo "Error: Failed to copy security-updates.sh to /root/"
  fi
else
  echo "security-updates.sh already exists in /root/"
fi
echo "security-updates.sh lives at /root/security-updates.sh"

#!/bin/bash

if [ ! -f "/etc/systemd/system/myupdater.service" ]; then
    sudo cp myupdater.service /etc/systemd/system/
    sudo systemctl enable myupdater.service
    sudo systemctl start myupdater.service
    if [ $? -eq 0 ]; then
        echo "myupdater.service installed and started successfully on $(hostname)."
    else
        echo "Error starting myupdater.service"
    fi
else
    echo "myupdater.service already installed on $(hostname)."
fi
