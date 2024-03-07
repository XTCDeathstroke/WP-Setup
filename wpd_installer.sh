#!/bin/bash

# Function to check if the last command was successful
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error: Command failed. Aborting."
        exit 1
    fi
}

# Update package lists
sudo apt update
check_success

# Install required packages
sudo apt install -y apache2 \
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
                    php-zip
check_success

echo "Installation completed successfully."
