#!/bin/sh

if ! [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    service mariadb start

    mariadb -u root -e "
    CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
    CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
    GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
    FLUSH PRIVILEGES;
    SHUTDOWN;"
fi

mysqld --user=mysql --bind-address=0.0.0.0 --console

