#!/bin/bash
set -e
# Faz o script parar se algo falhar

echo "A aguardar MariaDB..."
# Espera até a base de dados responder
until mariadb -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" -e "SELECT 1;" > /dev/null 2>&1; do
    sleep 2
done
echo "MariaDB disponível!"

cd /var/www/html

# Cria wp-config.php se ainda não existir
if [ ! -f wp-config.php ]; then

    echo "A criar wp-config.php..."

    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="mariadb" \
        --allow-root

fi

# Instala o WordPress se ainda não estiver instalado
if ! wp core is-installed --allow-root; then

    echo "A instalar WordPress..."

    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    # Cria utilizador adicional (não admin)
    wp user create \
        "$WP_USER" \
        "$WP_USER_EMAIL" \
        --role=editor \
        --user_pass="$WP_USER_PASSWORD" \
        --allow-root

fi

# Garante permissões corretas
chown -R www-data:www-data /var/www/html

echo "A iniciar PHP-FPM..."

# PHP-FPM em foreground (PID 1)
exec php-fpm8.2 -F

