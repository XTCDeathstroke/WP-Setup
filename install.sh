#!/bin/bash

# Function to check if the last command was successful
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error: $1. Aborting."
        exit 1
    fi
}

# Execute scripts
chmod +x apache2_installer.sh
check_success "Failed to make apache2_installer.sh executable"
./apache2_installer.sh
((successful++))
check_success "Failed to execute apache2_installer.sh"

chmod +x config_db.sh
check_success "Failed to make config_db.sh executable"
./config_db.sh
((successful++))
check_success "Failed to execute config_db.sh"

chmod +x wp_installer.sh
check_success "Failed to make wp_installer.sh executable"
./wp_installer.sh
((successful++))
check_success "Failed to execute wp_installer.sh"

chmod +x wpd_installer.sh
check_success "Failed to make wpd_installer.sh executable"
./wpd_installer.sh
((successful++))
check_success "Failed to execute wpd_installer.sh"

chmod +x wpdp_config.sh
check_success "Failed to make wpdp_config.sh executable"
./wpdp_config.sh
((successful++))
check_success "Failed to execute wpdp_config.sh"

echo "$successful/5 Successful."
