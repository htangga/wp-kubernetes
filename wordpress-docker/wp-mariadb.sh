#!/bin/bash

docker network create --attachable mariadb-wp-privnet
docker container run -d \
    --name wordpressdb \
    -e MYSQL_ROOT_PASSWORD='redhat' \
    -e MYSQL_DATABASE='wordpress' \
    -e MYSQL_USER='wordpress' \
    -e MYSQL_PASSWORD='redhat' \
    -v /var/lib/mysql:/var/lib/mysql \
    --network mariadb-wp-privnet \
    mariadb
docker container run -d \
    --name wordpress \
    -e WORDPRESS_DB_HOST='wordpressdb' \
    -e WORDPRESS_DB_USER='wordpress' \
    -e WORDPRESS_DB_PASSWORD='redhat' \
    -e WORDPRESS_DB_NAME='wordpress' \
    -v /var/www/html:/var/www/html \
    --network mariadb-wp-privnet \
    -p 80:80 \
    wordpress