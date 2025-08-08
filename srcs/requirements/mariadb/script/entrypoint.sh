#!/bin/bash
set -e

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then

    mysql_install_db --user=mysql

    while ! mysqladmin ping --silent; do
        sleep 1
    done

    cat << EOF > /init.sql

CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

    mysqld --user=mysql --bootstrap < /init.sql

    rm -f /init.sql
fi

exec mysqld --user=mysql