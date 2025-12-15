# Usamos Debian penúltima versão estável
# (bookworm é a penúltima se trixie for a atual)
FROM debian:bookworm

# Evita perguntas interativas durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza pacotes e instala MariaDB
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Cria diretório necessário para o socket do MariaDB
# Sem isto, o serviço pode falhar ao arrancar
RUN mkdir -p /run/mysqld \
    && chown -R mysql:mysql /run/mysqld

# Copiamos o script de arranque
COPY tools/entrypoint.sh /entrypoint.sh

# Tornamos o script executável
RUN chmod +x /entrypoint.sh

# Porta interna usada pelo MariaDB
EXPOSE 3306

# Definimos o entrypoint
# MariaDB será o processo PID 1 (boa prática)
ENTRYPOINT ["/entrypoint.sh"]

