FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y mariadb-server gosu \
    && rm -rf /var/lib/apt/lists/* \
    # supprimer toute initialisation faite par le package pour partir "vide"\
    && rm -rf /var/lib/mysql/* || true

COPY ./script/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY ./config/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /usr/local/bin/entrypoint.sh \
    && mkdir -p /run/mysqld \
    && chown -R mysql:mysql /run/mysqld

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["mysqld"]