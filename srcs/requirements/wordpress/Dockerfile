FROM debian:bullseye

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


RUN mkdir -p /var/www/wordpress

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN chown -R www-data:www-data /var/www/wordpress \
    && chmod -R 755 /var/www/wordpress
    
RUN mkdir /run/php

# Copy the WordPress setup script
COPY ./tools/create_wp.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wp.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/create_wp.sh"]

