#!/bin/bash

# Function to check if the last command was successful
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error: Command failed. Aborting."
        exit 1
    fi
}

# Prompt user for database name, username, and MySQL root password
read -p "Enter database name for WordPress: " dbname
check_success
read -p "Enter MySQL username for WordPress: " dbuser
check_success
read -s -p "Enter MySQL root password: " mysqlpassword
check_success

# Create MySQL commands
mysql_commands="CREATE DATABASE $dbname;
CREATE USER '$dbuser'@'localhost' IDENTIFIED BY '<your-password>';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON $dbname.* TO '$dbuser'@'localhost';
FLUSH PRIVILEGES;
quit"

# Execute MySQL commands
echo "$mysql_commands" | sudo mysql -u root -p"$mysqlpassword"
check_success

# Start MySQL service
sudo service mysql start
check_success

echo "MySQL database and user created successfully."
