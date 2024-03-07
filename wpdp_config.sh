#!/bin/bash

# Function to check if the last command was successful
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error: $1. Aborting."
        exit 1
    fi
}

# Get secret keys from WordPress API
echo "Retrieving secret keys from WordPress API..."
secret_keys=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
check_success "Failed to retrieve secret keys from WordPress API"

# Copy wp-config-sample.php to wp-config.php
sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php
check_success "Failed to copy wp-config-sample.php to wp-config.php"

# Configure wp-config.php with secret keys
echo "Configuring wp-config.php with secret keys..."
sudo -u www-data sed -i "/define('AUTH_KEY',/c\\$secret_keys" /srv/www/wordpress/wp-config.php
check_success "Failed to configure wp-config.php with secret keys"

echo "WordPress configuration completed successfully."
