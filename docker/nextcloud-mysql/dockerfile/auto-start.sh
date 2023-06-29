#!/bin/bash
# R.Tavares
# 28.06.2023 v1.11.1
# 
#

nextcloud_image=nextcloud-rta:latest
mariadb_image=mariadb-rta:latest

# run each container
docker run -d --name "mariadb" --volume mariadb:/var/lib/mysql $mariadb_image
docker run -d --name "nextcloud" -p 8080:80 --link mariadb:mariadb --volume nextcloud-root:/var/www/html --volume nextcloud-data:/var/www/html/data --volume nextcloud-config:/var/www/html/config $nextcloud_image
