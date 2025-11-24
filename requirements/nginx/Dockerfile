FROM debian:oldstable

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl /var/www/html;

COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN openssl req -x509 -nodes -days 365 \
    -subj "/C=PT/ST=Lisbon/L=Lisbon/O=42/Inception/CN=raamorim.42.fr" \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.cert

EXPOSE 80 443

ENTRYPOINT ["nginx"]

CMD["-g", "daemon off;"]
