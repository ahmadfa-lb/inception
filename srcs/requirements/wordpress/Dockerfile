# FROM debian:buster

# RUN apt-get update && apt-get -y install \
# wget \
# php \
# php-cgi \
# php-mysql \
# php-fpm \
# php-pdo \
# php-gd php-cli \
# php-mbstring \
# && rm -rf /var/lib/apt/lists/*

# COPY ./conf/www.conf /usr/local/etc/php/

# RUN mkdir /run/php

# COPY ./tools/create_wp.sh /usr/local/bin/
# # ENTRYPOINT ["create_wp.sh"]

# WORKDIR /var/www/html/

# EXPOSE 9000

# CMD ["/usr/sbin/php-fpm7.3", "-F"]

FROM debian:bullseye

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-pdo \
    php7.4-gd \
    php7.4-cli \
    php7.4-mbstring \
    mariadb-client

# && rm -rf /var/lib/apt/lists/*

# Copy PHP configuration
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./conf/wp-config.php /var/www/html/


# Ensure the directory exists before setting ownership/permissions
RUN mkdir -p /var/www/html/

# Copy custom WordPress files
COPY conf/projects_form.php /var/www/html/
COPY conf/process_projects.php /var/www/html/

# Ensure proper ownership and permissions
RUN chown -R www-data:www-data /var/www/html/ \
    && chmod -R 755 /var/www/html/
    
# Create necessary directories
RUN mkdir /run/php

# Copy the WordPress setup script
COPY ./tools/create_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wp.sh

# Set working directory
WORKDIR /var/www/html/

# Expose PHP-FPM port
EXPOSE 9000

# Execute the WordPress setup script before starting PHP-FPM
ENTRYPOINT ["/usr/local/bin/create_wp.sh"]

# Start PHP-FPM
CMD ["/usr/sbin/php-fpm7.4", "-F"]
