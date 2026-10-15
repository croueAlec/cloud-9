FROM mariadb:11.8

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

ENV MARIADB_DATABASE=test
ENV MARIADB_USER=test_user
ENV MARIADB_PASSWORD=password
ENV MARIADB_ROOT_PASSWORD=root

EXPOSE 3306
