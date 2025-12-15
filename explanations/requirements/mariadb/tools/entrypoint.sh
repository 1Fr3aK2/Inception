#!/bin/bash
set -e
# set -e garante que o script para se algum comando falhar

# Inicia o serviço MariaDB em background
# Necessário para podermos executar comandos SQL iniciais
service mariadb start

# Apenas executa a inicialização se a base de dados ainda não existir
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then

    echo "A inicializar base de dados MariaDB..."

    # Cria a base de dados do WordPress
    mariadb -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"

    # Cria o utilizador do WordPress
    mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

    # Dá permissões ao utilizador apenas sobre a base de dados necessária
    mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"

    # Aplica as permissões
    mariadb -e "FLUSH PRIVILEGES;"

fi

# Para o serviço iniciado em background
# Vamos relançar em foreground como PID 1
service mariadb stop

echo "MariaDB configurado. A iniciar em foreground..."

# Executa o MariaDB como processo principal
# Isto é CRUCIAL para Docker (PID 1)
exec mysqld_safe

