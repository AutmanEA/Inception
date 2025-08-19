FROM debian:bookworm

## Installing core
RUN apt-get upgrade -y > /dev/null && apt-get update -y > /dev/null
RUN apt-get install gettext-base > /dev/null

## Installing mariadb core
RUN apt-get install -y mariadb-server-core mariadb-client-core > /dev/null

## Debug (ps aux)
RUN apt-get install -y procps > /dev/null

## Cleaning apt-get unused cache
RUN rm -rf /var/lib/apt/lists/*

## Create user mysql
RUN groupadd -r mysql && useradd -r -g mysql mysql

## Config files and init sql
COPY ./utils/config.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./utils/init.sql /init.sql
RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

## Setup entrypoint
COPY ./utils/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]