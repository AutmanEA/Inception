FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y    \
    && apt-get install -y mariadb-server    \
    && rm -rf /var/lib/apt/lists/*          #

COPY ./config/config.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./script/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN mkdir -p /var/lib/mysql                     \
    && chown -R mysql:mysql /var/lib/mysql      \
    && mkdir -p /run/mysqld                     \
    && chown -R mysql:mysql /run/mysqld         \
    && chmod +x /usr/local/bin/entrypoint.sh    #

ENTRYPOINT ["entrypoint.sh"]