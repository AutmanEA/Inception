#!/bin/bash

if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "** Downloading wordpress... **"
    wp core download --path=/var/www/html --allow-root
    sleep 1

    echo "** Creating wp-config.php... **"
    wp config create                    \
        --dbname="$MYSQL_DATABASE"      \
        --dbuser="$MYSQL_USER"          \
        --dbpass="$MYSQL_PASSWORD"      \
        --dbhost=mariadb --allow-root
    sleep 1

    echo "** Waiting config to be ready... **"
    sleep 5

    echo "** Installing wordpress... **"
    wp core install                             \
        --url="$WP_URL_ALL"                     \
        --title="$WP_TITLE"                     \
        --admin_user="$WP_ADMIN_USER"           \
        --admin_password="$WP_ADMIN_PASSWORD"   \
        --admin_email="$WP_ADMIN_MAIL"          \
        --allow-root --skip-email
    sleep 1

    echo "** Creating extra user... **"
    wp user create "$WP_USER" "${WP_USER}@null.com" \
        --role=subscriber                           \
        --user_pass="$WP_USER_PASSWORD"             \
        --allow-root
    sleep 1
fi

echo "** Execute php-fpm service **"
exec php-fpm8.2 -F