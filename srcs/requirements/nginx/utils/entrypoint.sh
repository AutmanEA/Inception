#!/bin/bash

mkdir -p /etc/nginx/ssl

if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    echo "** Generating certificates... **"
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key                \
        -out /etc/nginx/ssl/nginx.crt                   \
        -subj "/CN=$WP_URL"
fi
sleep 1

ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

exec nginx -g "daemon off;"