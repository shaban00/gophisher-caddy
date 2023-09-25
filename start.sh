#!/bin/bash

# Prompt the user for a new hostname
read -p "Enter the new hostname: " new_hostname

# Check if the input is not empty
if [ -z "$new_hostname" ]; then
  echo "Hostname cannot be empty. Exiting."
  exit 1
fi

# Set the new hostname in /etc/hostname
echo "$new_hostname" | sudo tee /etc/hostname > /dev/null

# Update the current session's hostname
sudo hostnamectl set-hostname "$new_hostname"

# Update /etc/hosts to reflect the new hostname
sudo sed -i "s/127.0.1.1.*/127.0.1.1\t$new_hostname/g" /etc/hosts

# Notify the user about the hostname change
echo "Hostname changed to $new_hostname."

# You may need to restart the system or the network service for the change to take effect
sudo systemctl restart systemd-hostnamed


sudo ufw allow OpenSSH     # Allow SSH (default port 22)
sudo ufw allow 80/tcp     # Allow HTTP (default port 80)
sudo ufw allow 443/tcp    # Allow HTTPS (default port 443)

sudo ufw enable

sudo ufw status

sudo ufw reload

sudo docker compose up -d