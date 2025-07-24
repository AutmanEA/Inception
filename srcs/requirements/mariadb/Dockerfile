FROM debian:bullseye

RUN apt-get update && apt-get upgrade       \
    && apt-get install -y mariadb-server    \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 3306

COPY config/config.cnf /etc/mysql/config.cnf
COPY config/init.sql /entrypoint-initdb.d/
COPY script/entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]