#!/bin/bash

# Function to check if the last command was successful
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error: Command failed. Aborting."
        exit 1
    fi
}

# Create the Apache site configuration file
echo "<VirtualHost *:80>
    DocumentRoot /srv/www/wordpress
    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>" | sudo tee /etc/apache2/sites-available/wordpress.conf > /dev/null
check_success

# Enable the site
sudo a2ensite wordpress
check_success

# Enable URL rewriting
sudo a2enmod rewrite
check_success

# Disable the default site
sudo a2dissite 000-default
check_success

# Reload Apache to apply changes
sudo service apache2 reload
check_success

echo "Apache site configuration for WordPress completed successfully."
