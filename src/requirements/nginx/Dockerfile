FROM debian:oldstable

RUN apt-get update && apt-get install -y nginx && apt-get install -y openssl        

# Cria diretórios necessários
RUN mkdir -p /etc/nginx/ssl /var/www/html;   
# Cria as pastas para SSL e conteúdo web

COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN openssl req -x509 -nodes -days 365 \	
    -subj "/C=PT/ST=Lisbon/L=Lisbon/O=42/Inception/CN=raamorim.42.fr" \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.cert  && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* 

# Cria um certificado X.509 válido por 365 dias
# Define informações do certificado
# Cria uma nova chave RSA de 2048 bits
# Caminho onde será guardada a chave privada
# Caminho do certificado gerado

EXPOSE 443

ENTRYPOINT ["nginx"]   

CMD ["-g", "daemon off;"]   
