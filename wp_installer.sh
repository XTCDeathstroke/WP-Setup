#!/bin/bash

# Function to check if the last command was successful
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error: Command failed. Aborting."
        exit 1
    fi
}

# Create directory /srv/www and change ownership
sudo mkdir -p /srv/www
check_success
sudo chown www-data: /srv/www
check_success

# Download and extract WordPress
curl -o /tmp/latest.tar.gz https://wordpress.org/latest.tar.gz
check_success
sudo -u www-data tar zx -C /srv/www -f /tmp/latest.tar.gz
check_success

echo "WordPress installation completed successfully."
