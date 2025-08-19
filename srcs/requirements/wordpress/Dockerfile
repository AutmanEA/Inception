FROM debian:bookworm

## Installing core
RUN apt-get upgrade -y > /dev/null && apt-get update -y > /dev/null
RUN apt-get install -y curl > /dev/null

## Debug (ps aux)
RUN apt-get install -y procps > /dev/null

## Installing php (core), php-mysql (mariadb <-> php), php-fpm (nginx <-> php) 
RUN apt-get install -y php8.2 php8.2-mysql php8.2-fpm > /dev/null

## Cleaning apt-get unused cache
RUN rm -rf /var/lib/apt/lists/*

## Downloading WP-CLI and allow 'wp' command (to setup wordpress with scripts)
WORKDIR /var/www/html
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/bin/wp

## Setup entrypoint
COPY ./utils/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

## Setup config
COPY ./utils/config.conf /etc/php/8.2/fpm/pool.d/www.conf

## add permissions to install wordpress
RUN chown -R www-data:www-data /var/www/html
RUN chmod 755 /var/www/html

ENTRYPOINT [ "entrypoint.sh" ]