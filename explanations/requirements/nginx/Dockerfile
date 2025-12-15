# Base: Debian penúltima versão estável
FROM debian:bookworm

# Evita prompts interativos
ENV DEBIAN_FRONTEND=noninteractive

# Instala NGINX e OpenSSL
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Cria diretório para certificados SSL
RUN mkdir -p /etc/nginx/ssl

# Gera certificado autoassinado
# Permitido para ambiente local
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:4096 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=PT/ST=Lisboa/L=Lisboa/O=42/OU=Inception/CN=raamorim.42.fr"

# Remove configuração default do NGINX
RUN rm /etc/nginx/sites-enabled/default

# Copia a configuração personalizada
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# Expõe apenas HTTPS
EXPOSE 443

# Arranca o NGINX em foreground
CMD ["nginx", "-g", "daemon off;"]

