# Usamos a versão estável mais recente do Debian (bookworm)
FROM debian:bookworm

# Evita perguntas interativas durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza o sistema e instala dependências necessárias
RUN apt-get update && apt-get install -y \
    php8.2 \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-cli \
    php8.2-curl \
    php8.2-gd \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-zip \
    mariadb-client \
    curl \
    wget \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Cria diretório do WordPress
RUN mkdir -p /var/www/html

# Define permissões corretas
RUN chown -R www-data:www-data /var/www/html

# Instala o WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copia o script de inicialização
COPY tools/wordpress_setup.sh /usr/local/bin/wordpress_setup.sh

# Dá permissões de execução ao script
RUN chmod +x /usr/local/bin/wordpress_setup.sh

# Define o diretório de trabalho
WORKDIR /var/www/html

# Expõe a porta do PHP-FPM
EXPOSE 9000

# Executa o script (processo principal do container)
ENTRYPOINT ["/usr/local/bin/wordpress_setup.sh"]

