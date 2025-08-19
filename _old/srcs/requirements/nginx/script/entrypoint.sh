#!/bin/bash
set -e

mkdir -p /etc/nginx/ssl
mkdir -p /etc/nginx/nginx

if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=FR/ST=France/L=Angouleme/O=42School/OU=student/CN=$WP_URL"
fi

envsubst '${WP_URL}' < /etc/nginx/sites-available/default.conf > /etc/nginx/sites-available/default
ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

nginx -t

exec nginx -g "daemon off;"