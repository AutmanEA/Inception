FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y        \
    && apt-get install -y nginx openssl gettext \
    && rm -rf /var/lib/apt/lists/*              \
    && rm -f /etc/nginx/sites-enabled/default   #

COPY ./config/nginx.conf /etc/nginx/sites-available/default.conf
COPY ./script/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]