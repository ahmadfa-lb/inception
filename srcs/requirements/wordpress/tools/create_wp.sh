#!/bin/sh

# if [ -f /var/www/html/wordpress/wp-config.php ]; then
#     echo "WordPress already installed."
# fi

if [ -f /var/www/html/wordpress/wp-config.php ]
then
	echo "wordpress already downloaded"
else
	#Download wordpress
	# wget https://wordpress.org/latest.tar.gz
	# tar -xzvf latest.tar.gz -C /var/www/html/
	# rm -rf latest.tar.gz

	echo "Downloading WordPress..."
	wget -c --tries=3 https://wordpress.org/latest.tar.gz || { echo "Download failed"; exit 1; }
    tar -xzvf latest.tar.gz -C /var/www/html/ || { echo "Extraction failed"; exit 1; }
    rm latest.tar.gz

	# #Update configuration file
	# rm -rf /etc/php/7.4/fpm/pool.d/www.conf
	# mv ./conf/www.conf /etc/php/7.4/fpm/pool.d/

	# Set proper ownership and permissions
	chown -R www-data:www-data /var/www/html/
	chmod -R 755 /var/www/html/

	# Copy custom WordPress files if not already present
	if [ ! -f "/var/www/html/wordpress/projects_form.php" ]; then
  		cp ../conf/projects_form.php /var/www/html/
	fi

	if [ ! -f "/var/www/html/wordpress/process_projects.php" ]; then
  		cp ../conf/process_projects.php /var/www/html/
	fi

	
	echo "Configuring wp-config.php..."
	cd /var/www/html/wordpress
	cp wp-config-sample.php wp-config.php
	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	# mv wp-config-sample.php wp-config.php
fi

# Ensure the database is populated
if ! mysql -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "USE $MYSQL_DATABASE; SHOW TABLES;" | grep -q "wp_options"; then
    echo "Running WordPress installation..."
    wp core install \
        --url="$WP_HOME" \
        --title="My WordPress Site" \
        --admin_user="admin" \
        --admin_password="admin_password" \
        --admin_email="admin@example.com" \
        --path="/var/www/html/wordpress" \
        --allow-root
else
    echo "Database already initialized."
fi


exec php-fpm7.4 -F

# exec "$@"