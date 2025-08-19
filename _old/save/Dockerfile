FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y    \
    && apt-get install -y mariadb-server-core \
    && rm -rf /var/lib/apt/lists/*          \
    && rm -rf /var/lib/mysql/*              #
    
COPY ./script/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY ./config/config.conf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/lib/mysql                     \
    && chown -R mysql:mysql /var/lib/mysql      \
    && mkdir -p /run/mysqld                     \
    && chown -R mysql:mysql /run/mysqld         \
    && chmod +x /usr/local/bin/entrypoint.sh    #

ENTRYPOINT ["entrypoint.sh"]