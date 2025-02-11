# #!/bin/sh

# if [ -f ./wordpress/conf/wp-config.php ]
# then
# 	echo "wordpress already downloaded"
# else
# 	#Download wordpress
# 	wget https://wordpress.org/latest.tar.gz
# 	tar -xzvf latest.tar.gz
# 	rm -rf latest.tar.gz

# 	#Update configuration file
# 	rm -rf /etc/php/7.3/fpm/pool.d/www.conf
# 	mv ./www.conf /etc/php/7.3/fpm/pool.d/

# 	#Inport env variables in the config file
# 	cd /var/www/html/wordpress
# 	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
# 	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
# 	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
# 	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
# 	mv wp-config-sample.php wp-config.php
# fi

# exec "$@"

# #!/bin/sh

# # Define the WordPress directory
# WP_DIR="/var/www/html/wordpress"
# PHP_CONF_DIR="/etc/php/7.3/fpm/pool.d"

# # Check if WordPress is already downloaded
# if [ -f "$WP_DIR/wp-config.php" ]; then
#     echo "WordPress is already downloaded and configured."
# else
#     # Download WordPress
#     echo "Downloading WordPress..."
#     wget https://wordpress.org/latest.tar.gz -O /tmp/latest.tar.gz
#     tar -xzf /tmp/latest.tar.gz -C /var/www/html
#     rm -f /tmp/latest.tar.gz
#     echo "WordPress downloaded and extracted to $WP_DIR."

#     # Update PHP configuration
#     if [ -f "./www.conf" ]; then
#         echo "Updating PHP configuration..."
#         rm -f "$PHP_CONF_DIR/www.conf"
#         cp ./www.conf "$PHP_CONF_DIR/"
#     else
#         echo "Warning: PHP configuration file www.conf not found!"
#     fi

#     # Configure WordPress
#     echo "Configuring WordPress..."
#     cd "$WP_DIR"
#     sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
#     sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
#     sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
#     sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
#     mv wp-config-sample.php wp-config.php
#     echo "WordPress configuration updated."
# fi

# # Execute the command passed to the script
# exec "$@"


#!/bin/bash

# Define the WordPress directory
WP_DIR="/var/www/html/wordpress"
PHP_CONF_DIR="/etc/php/7.3/fpm/pool.d"

# Check if WordPress is already downloaded
if [ -f "$WP_DIR/wp-config.php" ]; then
    echo "WordPress is already downloaded and configured."
else
    # Download WordPress
    echo "Downloading WordPress..."
    wget https://wordpress.org/latest.tar.gz -O /tmp/latest.tar.gz
    if [ $? -ne 0 ]; then
        echo "Error downloading WordPress. Exiting."
        exit 1
    fi
    tar -xzf /tmp/latest.tar.gz -C /var/www/html
    rm -f /tmp/latest.tar.gz
    echo "WordPress downloaded and extracted to $WP_DIR."

    # Update PHP configuration
    if [ -f "./www.conf" ]; then
        echo "Updating PHP configuration..."
        rm -f "$PHP_CONF_DIR/www.conf"
        cp ./www.conf "$PHP_CONF_DIR/"
    else
        echo "Warning: PHP configuration file www.conf not found!"
    fi

    # Configure WordPress
    echo "Configuring WordPress..."
    cd "$WP_DIR" || { echo "Failed to change directory to $WP_DIR"; exit 1; }
    sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
    sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
    sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
    sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
    mv wp-config-sample.php wp-config.php
    echo "WordPress configuration updated."
fi

# Execute the command passed to the script
exec "$@"
