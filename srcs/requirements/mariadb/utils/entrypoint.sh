#!/bin/bash

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "** Installing database... **"
    mysql_install_db --user=mysql
    sleep 1
fi

echo "** Build temp databse **"
mysqld --user=mysql --skip-networking & pid=$!
sleep 1

echo "** Waiting for database... **"
sleep 5

echo "** Init table **"
envsubst < /init.sql | mariadb -u root -p"${MYSQL_ROOT_PASSWORD}"
sleep 1

echo "** Shutdown temp database **"
kill $!
wait $!
sleep 1

echo "** Execute database **"
exec mysqld --user=mysql