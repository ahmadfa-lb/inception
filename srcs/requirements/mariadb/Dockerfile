FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server && \
    rm -rf /var/lib/apt/lists/*

    
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql


COPY tools/setup.sh /data/setup.sh
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/
RUN chmod +x /data/setup.sh

EXPOSE 3306

CMD ["bash", "/data/setup.sh"]