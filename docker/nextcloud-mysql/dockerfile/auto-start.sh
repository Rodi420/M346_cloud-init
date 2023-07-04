#!/bin/bash
# R. Tavares
# 28.06.2023 v1.11.5
# 
#
###########################################
# EDITABLE                                #
###########################################
nextcloud_image=imageName1:latest
mariadb_image=imageName2:latest
custom_dir=yourDir
###########################################

enable_build=0

#check for sudo privileges
if [ "$EUID" -ne 0 ]; then
    error_code=1
    echo -e "Error $error_code: Permissions not found. Please run with sudo enabled."
    echo "Reminder to adjust variables if your IMAGES and DIRECTORIES have different names!!!"
    exit
fi

echo "Would you like to build images or just run the containers?"
echo "1. Build and Run"
echo "2. Run only (Default)"
read -r -p "Input: " enable_build ;

if [[ $enable_build -eq 1 ]]
then
    echo "What image name would you like to use for Nextcloud?"
    read -r -p "Input: " nextcloud_name ;

    echo "What would you like to name this Nextcloud version?"
    read -r -p "Input: " nextcloud_version ;

    docker build -t "$nextcloud_name:$nextcloud_version" ./nc

    echo "What image name would you like to use for MariaDB?"
    read -r -p "Input: " mariadb_name ;

    echo "What would you like to name this MariaDB version?"
    read -r -p "Input: " mariadb_version ;

    docker build -t "$mariadb_name:$mariadb_version" ./db

    nextcloud_image="$nextcloud_name:$nextcloud_version"
    mariadb_image="$mariadb_name:$mariadb_version"

    echo "Do you want to set a custom directory for your Container Volumes?"
    echo "Default folder is: /$custom_dir/*"
    echo "1. Yes"
    echo "2. No"
    read -r -p "Input: " enable_customDir ;

    if [[ $enable_customDir -eq 1 ]]
    then
        echo "What would you like to name your custom directory?"
        read -r -p "Input: " custom_dir ;
    fi
fi

#if any folders missing create them
if [[ ! -d "/${custom_dir}" ]]
then
    echo "Info: Custom Directory does not exist. Creating it..."
    mkdir "/${custom_dir}"
fi
if [[ ! -d "/${custom_dir}/mariadb" ]]
then
    echo "Info: MariaDB Directory does not exist. Creating it..."
    mkdir "/${custom_dir}/mariadb"
fi
if [[ ! -d "/${custom_dir}/nextcloud-root" ]]
then
    echo "Info: Nextcloud Root Directory does not exist. Creating it..."
    mkdir "/${custom_dir}/nextcloud-root"
fi
if [[ ! -d "/${custom_dir}/nextcloud-data" ]]
then
    echo "Info: Nextcloud Data Directory does not exist. Creating it..."
    mkdir "/${custom_dir}/nextcloud-data"
fi
if [[ ! -d "/${custom_dir}/nextcloud-config" ]]
then
    echo "Info: Nextcloud Config Directory does not exist. Creating it..."
    mkdir "/${custom_dir}/nextcloud-config"
fi

# run each container
docker run -d --name "mariadb" --volume /$custom_dir/mariadb:/var/lib/mysql $mariadb_image
docker run -d --name "nextcloud" -p 8080:80 --link mariadb:mariadb --volume /$custom_dir/nextcloud-root:/var/www/html --volume /$custom_dir/nextcloud-data:/var/www/html/data --volume /$custom_dir/nextcloud-config:/var/www/html/config $nextcloud_image
