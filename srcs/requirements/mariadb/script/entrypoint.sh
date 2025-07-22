#!/bin/bash
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
fi

mysqld_safe --basedir=/usr &

until mysqladmin ping --silent; do
    sleep 1
done

mysql < /entrypoint-initdb.d/init.sql

mysqladmin shutdown

exec mysqld_safe --basedir=/usr