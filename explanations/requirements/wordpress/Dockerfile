# Base: Debian penúltima versão estável
FROM debian:bookworm

# Evita prompts interativos
ENV DEBIAN_FRONTEND=noninteractive

# Instala PHP-FPM e extensões necessárias ao WordPress
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-cli \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    php-zip \
    mariadb-client \
    curl \
    wget \
    less \
    && rm -rf /var/lib/apt/lists/*

# Diretório onde o WordPress vai ficar
RUN mkdir -p /var/www/html

# Download do WordPress oficial
RUN wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz \
    && tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 \
    && rm /tmp/wordpress.tar.gz

# Download do WP-CLI oficial
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Permissões corretas para o PHP-FPM
RUN chown -R www-data:www-data /var/www/html

# Copia o script de arranque
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Porta usada pelo PHP-FPM
EXPOSE 9000

# Processo principal
ENTRYPOINT ["/entrypoint.sh"]

