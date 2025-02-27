FROM debian:bullseye

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    curl\
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-pdo \
    php7.4-gd \
    php7.4-cli \
    php7.4-mbstring \
    mariadb-client

# && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/wordpress

# Copy PHP configuration
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./conf/wp-config.php /var/www/wordpress/


# Ensure the directory exists before setting ownership/permissions


# Ensure proper ownership and permissions
RUN chown -R www-data:www-data /var/www/wordpress \
    && chmod -R 755 /var/www/wordpress
    
# Create necessary directories
RUN mkdir /run/php

# Copy the WordPress setup script
COPY ./tools/create_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wp.sh

# Set working directory
# WORKDIR /var/www/wordpress/

# Expose PHP-FPM port
EXPOSE 9000

# Execute the WordPress setup script before starting PHP-FPM
ENTRYPOINT ["/usr/local/bin/create_wp.sh"]

# Start PHP-FPM
CMD ["/usr/sbin/php-fpm7.4", "-F"]
