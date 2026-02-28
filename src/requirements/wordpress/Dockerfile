FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y curl \
 php-fpm php-mysql \
 php-mbstring php-xml php-gd php-curl php-zip

RUN sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|g' /etc/php/8.2/fpm/pool.d/www.conf

WORKDIR /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
 && chmod +x wp-cli.phar \
 && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php

COPY tools/wordpress.sh /etc/wordpress.sh
RUN chmod +x /etc/wordpress.sh
ENTRYPOINT [ "sh", "/etc/wordpress.sh" ]


