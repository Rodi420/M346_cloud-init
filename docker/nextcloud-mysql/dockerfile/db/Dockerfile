FROM mariadb:10.6
ENV MYSQL_ROOT_PASSWORD=12345
ENV MYSQL_PASSWORD=123
ENV MYSQL_DATABASE=nextcloud
ENV MYSQL_USER=nextcloud
CMD ["--transaction-isolation=READ-COMMITTED", "--log-bin=binlog", "--binlog-format=ROW"] 