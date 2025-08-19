## Based on the antepenultiam stable debian
FROM debian:bookworm-20250224

## Install Wp
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-redis \
    php8.2-curl \
    php8.2-xml \
    php8.2-zip

RUN rm -rf /var/www/html/* || true

RUN apt-get install -y curl

## Create group and user nginx to avoid conflics in volumes
RUN groupadd --gid 1000 nginx && useradd -g nginx -u 1000 nginx

## Remove unused cache from installation
RUN rm -rf /var/lib/apt/lists/*

## Define Workdirectory
WORKDIR /var/www/html

## Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar # && 
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/bin/wp

## Create PHP_FPM repository && add to group
RUN mkdir -p /run/php && \
    chown -R 1000:1000 /run/php 
    #chown www-data:www-data /run/php

## COPY PHP Configuration
COPY ./config/config.conf /etc/php/8.2/fpm/pool.d/www.conf

## Copy setup script, add persmissions and add group
COPY ./script/entrypoint.sh /setup/wordpress_setup.sh
RUN chmod +x /setup/wordpress_setup.sh && \
    chown -R 1000:1000 /var/www/html && \
    chmod 755 /var/www/html
    #chown -R root:root /var/www/html

## Use script as entrypoint
ENTRYPOINT ["/setup/wordpress_setup.sh"]