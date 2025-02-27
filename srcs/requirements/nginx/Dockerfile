FROM debian:buster

RUN apt-get update && apt-get install -y \
    nginx \
    openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create the directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Generate the SSL certificate
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/server.crt \
    -keyout /etc/nginx/ssl/server.key \
    -subj "/C=LB/ST=Beirut/L=Beirut/O=42 School/OU=Beirut/CN=afarachi/"

RUN mkdir -p /run/nginx

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf


EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
