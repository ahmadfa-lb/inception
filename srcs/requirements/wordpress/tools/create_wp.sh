#!/bin/sh

echo "Downloading WordPress..."
wget -c --tries=3 https://wordpress.org/latest.tar.gz || { echo "Download failed"; exit 1; }

# Extract directly into the correct location
mkdir -p /var/www/wordpress
tar -xzvf latest.tar.gz -C /var/www/ || { echo "Extraction failed"; exit 1; }
rm latest.tar.gz

# Move the WordPress content to /var/www/wordpress
# mv /var/www/wordpress/wordpress/* /var/www/wordpress/
# rm -rf /var/www/wordpress/wordpress

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Set proper ownership and permissions
chown -R www-data:www-data /var/www/wordpress/
chmod -R 755 /var/www/wordpress/

# echo "Configuring wp-config.php..."
# cd /var/www/wordpress
# cp wp-config-sample.php wp-config.php
# sed -i "s/username_here/$MYSQL_USER/g" wp-config.php
# sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php
# sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config.php
# sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php

echo "Running WordPress installation..."
wp core install \
    --url="$WP_HOME" \
    --title="My WordPress Site" \
    --admin_user="admin" \
    --admin_password="admin_password" \
    --admin_email="admin@example.com" \
    --path="/var/www/wordpress" \
    --allow-root

exec php-fpm7.4 -F
