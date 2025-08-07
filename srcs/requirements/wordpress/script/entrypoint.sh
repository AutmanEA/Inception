#!/bin/bash
set -e

mkdir -p /run/php
chown -R www-data:www-data /run/php

if [ ! -f /var/www/html/wp-config.php ]; then
    
    wp core download --allow-root --path=/var/www/html
    
    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="$MYSQL_HOST" \
        --allow-root \
        --path=/var/www/html
    
    wp core install \
        --url="$WORDPRESS_URL" \
        --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --allow-root \
        --path=/var/www/html
    
    wp user create "$WORDPRESS_USER" "$WORDPRESS_USER_EMAIL" \
        --role=author \
        --user_pass="$WORDPRESS_USER_PASSWORD" \
        --allow-root \
        --path=/var/www/html

fi

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

exec php-fpm7.4 --nodaemonize