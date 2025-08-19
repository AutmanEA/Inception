#!/usr/bin/env bash
set -e

DATADIR=/var/lib/mysql

echo "SALUT"

# si jamais des fichiers existent, on ne ré-crée pas la base
if [ ! -d "$DATADIR/mysql" ]; then
  echo "Initialisation de MariaDB dans $DATADIR"
  # essayer mysql_install_db puis fallback vers mariadb-install-db
  if command -v mysql_install_db >/dev/null 2>&1; then
    mysql_install_db --user=mysql --datadir="$DATADIR"
  else
    mariadb-install-db --user=mysql --datadir="$DATADIR"
  fi

  # démarre mysqld en arrière-plan pour exécuter les SQL d'init
  mysqld_safe --datadir="$DATADIR" &
  pid=$!

  # attendre que le serveur soit prêt
  until mysqladmin ping --silent; do
    sleep 1
  done

  # créer DB & user depuis variables d'environnement
  mysql -u root << EOSQL
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOSQL

  # arrêter le serveur temporaire
  mysqladmin shutdown || kill "$pid" || true
fi

echo "COUCOU"
# enfin démarrer en avant-plan
exec mysqld --user=mysql --datadir="$DATADIR"