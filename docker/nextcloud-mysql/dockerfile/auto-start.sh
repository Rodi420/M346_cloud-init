#!/bin/bash
# R.Tavares
# 28.06.2023 v1.11.2
# 
#

nextcloud_image=nextcloud-rta:latest
mariadb_image=mariadb-rta:latest
custom_dir=bbw

if [ "$EUID" -ne 0 ]; then
  errorCode=1
  echo -e "Error $errorCode: Permissions not found. Please run with sudo enabled."
  exit
fi

if [[ ! -d "/${custom_dir}" ]]
then
    echo "Info: Custom Directory does not exist. Creating it..."
    mkdir "/${custom_dir}"
elif [[ ! -d "/${custom_dir}/mariadb" ]]
then
    echo "Info: MariaDB Directory does not exist. Creating it..."
    mkdir "/${custom_dir}/mariadb"
elif [[ ! -d "/${custom_dir}/nextcloud-root" ]]
then
    echo "Info: Nextcloud Root Directory does not exist. Creating it..."
    mkdir "/${custom_dir}/nextcloud-root"
elif [[ ! -d "/${custom_dir}/nextcloud-data" ]]
then
    echo "Info: Nextcloud Data Directory does not exist. Creating it..."
    mkdir "/${custom_dir}/nextcloud-data"
elif [[ ! -d "/${custom_dir}/nextcloud-config" ]]
then
    echo "Info: Nextcloud Config Directory does not exist. Creating it..."
    mkdir "/${custom_dir}/nextcloud-config"
fi




# run each container
docker run -d --name "mariadb" --volume /$custom_dir/mariadb:/var/lib/mysql $mariadb_image
docker run -d --name "nextcloud" -p 8080:80 --link mariadb:mariadb --volume /$custom_dir/nextcloud-root:/var/www/html --volume /$custom_dir/nextcloud-data:/var/www/html/data --volume /$custom_dir/nextcloud-config:/var/www/html/config $nextcloud_image
