#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MySQL data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Create a SQL initialization file
cat > /tmp/init.sql << EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# Start MySQL with initialization file - this runs in the foreground
echo "Starting MySQL with initialization..."
exec mysqld --user=mysql --init-file=/tmp/init.sql --console