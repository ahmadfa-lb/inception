#!/bin/bash

required_vars=("MYSQL_ROOT_PASSWORD" "MYSQL_DATABASE" "MYSQL_USER" "MYSQL_PASSWORD")
for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "Missing required environment variable $var"
        exit 1
    fi
done

# Start MariaDB in the background
mysqld_safe 

# Wait for MariaDB to be ready
until mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" ping --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

# Run MariaDB initialization commands
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS ${MYSQL_USER}@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO ${MYSQL_USER}@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# Shutdown MariaDB to let mysqld take over in the container
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Start MariaDB in the foreground
exec mysqld
