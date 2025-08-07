FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y    \
    && apt-get install -y mariadb-server    \
    && rm -rf /var/lib/apt/lists/*          \
    && mkdir /entrypoint-initdb.d           #

EXPOSE 3306

COPY ./config/config.cnf /etc/mysql/config.cnf
COPY ./script/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]