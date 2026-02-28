FROM debian:oldstable

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y mariadb-server mariadb-client && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

COPY tools/entry.sh /etc/entry.sh

RUN chmod +x /etc/entry.sh

EXPOSE 3306

ENTRYPOINT ["sh", "/etc/entry.sh"]

