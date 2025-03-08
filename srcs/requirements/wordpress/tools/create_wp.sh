#!/bin/sh

echo "Downloading WordPress..."
wget -c --tries=3 https://wordpress.org/latest.tar.gz || { echo "Download failed"; exit 1; }

tar -xzvf latest.tar.gz -C /var/www/ || { echo "Extraction failed"; exit 1; }
rm latest.tar.gz


curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp


cd /var/www/wordpress/

chown -R www-data:www-data /var/www/wordpress/
chmod -R 755 /var/www/wordpress/

echo "Running WordPress installation..."

wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --allow-root  --skip-check

echo "Wordpress: creating users..."


wp core install --allow-root --url=${DOMAIN_NAME} --title=${MYSQL_DATABASE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL}


wp user create --allow-root ${MYSQL_USER} ${WP_USER_EMAIL} --user_pass=${MYSQL_PASSWORD};

exec php-fpm7.4 -F
