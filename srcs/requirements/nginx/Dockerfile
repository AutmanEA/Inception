FROM debian:bookworm

## Installing core
RUN apt-get upgrade -y > /dev/null && apt-get update -y > /dev/null

## Debug (ps aux)
RUN apt-get install -y procps > /dev/null

## Installing nginx (core) and openssl (for security <https>)
RUN apt-get install -y nginx openssl > /dev/null

## Cleaning apt-get unused cache
RUN rm -rf /var/lib/apt/lists/*

## Setup config file
COPY ./utils/config.conf /etc/nginx/sites-available/default

## Setup entrypoint
COPY ./utils/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]