FROM mariadb:11.8

RUN ln -s /usr/local/bin/healthcheck.sh healthcheck.sh

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306
