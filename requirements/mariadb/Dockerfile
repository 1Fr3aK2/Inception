# Usa a imagem base Debian Oldstable (não usa imagem pronta do MariaDB)
FROM debian:oldstable

# Atualiza a lista de pacotes e atualiza o sistema
# Depois instala o MariaDB server e cliente
RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y mariadb-server mariadb-client && rm -rf /var/lib/apt/lists/*

# Copia o script de inicialização para dentro do container
COPY tools/entry.sh /etc/entry.sh

# Dá permissão de execução para o script de inicialização
RUN chmod +x /etc/entry.sh

EXPOSE 3306


# Define o script como entrypoint do container
# Ele será executado sempre que o container iniciar
ENTRYPOINT ["bash", "/etc/entry.sh"]

