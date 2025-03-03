#!/bin/bash

required_vars=("MYSQL_ROOT_PASSWORD" "MYSQL_DATABASE" "MYSQL_USER" "MYSQL_PASSWORD")
for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "Missing required environment variable $var"
        exit 1
    fi
done

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    mysqld --user=mysql --skip-networking
    pid="$!"

    # Wait for MariaDB to be ready
    echo "Waiting for MariaDB to start..."
    until mysqladmin -uroot ping --silent; do
        sleep 2
    done

    # Run setup SQL commands
    mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    # Shutdown the temporary MariaDB instance
    mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown
fi

# Start MariaDB in the foreground
exec mysqld --user=mysql --console
