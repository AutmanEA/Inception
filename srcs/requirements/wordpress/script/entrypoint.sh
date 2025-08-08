#!/bin/bash
set -e

mkdir -p /run/php
chown -R www-data:www-data /run/php

cd /var/www/html

sleep 10


if [ ! -f wp-config.php ] && [ ! -d wp-admin ]; then
    wp core download --allow-root
    
    wp config create                \
        --dbname="$MYSQL_DATABASE"  \
        --dbuser="$MYSQL_USER"      \
        --dbpass="$MYSQL_PASSWORD"  \
        --dbhost="$MYSQL_HOST"      \
        --allow-root                #

    echo "!!!!!!!! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! config create ok"
    
    wp core install \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PW" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root                    #
        
    echo "installation de wp ok"
    
    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PW" \
        --allow-root #
        
    echo "user secondaire a ete bien cree ok"

fi
echo "tout ok si tas lu fichier a generer"

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
echo "chown et chmod ici"

exec php-fpm7.4 --nodaemonize