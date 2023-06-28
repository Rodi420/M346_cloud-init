#!/bin/bash
# R.Tavares
# 28.06.2023 v1.11
# 
#

nextcloud_image=nextcloud-rta:latest
mariadb_image=mariadb-rta:latest

# run each container
docker run -d --name "mariadb" --volume mariadb:/var/lib/mysql $mariadb_image
docker run -d --name "nextcloud" -p 8080:80 --links mariadb:mariadb --volume nextcloud:/var/www/html $nextcloud_image
