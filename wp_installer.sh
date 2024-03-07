#!/bin/bash

# Function to display error message and exit
function handle_error {
    echo "Error: $1"
    exit 1
}

# Update package list
sudo apt update || handle_error "Failed to update package list."

# Install required packages
sudo apt install -y \
    apache2 \
    ghostscript \
    libapache2-mod-php \
    mysql-server \
    php \
    php-bcmath \
    php-curl \
    php-imagick \
    php-intl \
    php-json \
    php-mbstring \
    php-mysql \
    php-xml \
    php-zip || handle_error "Failed to install required packages."

# Create directory for WordPress installation
sudo mkdir -p /srv/www || handle_error "Failed to create directory for WordPress installation."
sudo chown www-data: /srv/www || handle_error "Failed to set ownership for WordPress directory."

# Download and extract latest WordPress
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www || handle_error "Failed to download and extract WordPress."

# Create Apache site configuration for WordPress
cat <<EOF | sudo tee /etc/apache2/sites-available/wordpress.conf || handle_error "Failed to create Apache site configuration."
<VirtualHost *:80>
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
</VirtualHost>
EOF

# Enable the WordPress site
sudo a2ensite wordpress || handle_error "Failed to enable WordPress site."

# Enable URL rewriting
sudo a2enmod rewrite || handle_error "Failed to enable URL rewriting."

# Disable the default "It Works" site
sudo a2dissite 000-default || handle_error "Failed to disable default site."

# Reload Apache to apply changes
sudo service apache2 reload || handle_error "Failed to reload Apache."
