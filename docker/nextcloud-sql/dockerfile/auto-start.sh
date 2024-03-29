#!/bin/bash
# R. Tavares
# 28.06.2023 v1.11.11
# 
#
###########################################
# EDITABLE                                #
###########################################
nc_image=nc1:1
db_image=db1:1
dir_name=bbw
nc_port=8080
###########################################
# EDIT AT OWN RISK (volume configuration) #
###########################################
nc_volRoot=nextcloud-root
nc_volData=nextcloud-data
nc_volConf=nextcloud-config
###########################################

#used in en_conSingle
nc_on=1
db_on=1

#used in en_conName
nc_conName=nextcloud
db_conName=mariadb


#check for sudo privileges
if [ "$EUID" -ne 0 ] ; then
    error_code=1
    echo -e "Error $error_code: Permissions not found. Please run with sudo enabled."
    echo "Reminder to adjust variables if your IMAGES and DIRECTORIES have different names!!!"
    exit
fi

#build images?
en_imgBuild=0

echo "What would you like to do?"
echo "1. Build and Run Containers"
echo "2. Run Containers only (Default)"
echo "3. Stop running Containers"
read -r -p "Input: " en_imgBuild ;

if [[ $en_imgBuild -eq 3 ]] ; then
    #get running container names and IDs
    en_conInfo=$(docker ps --format '{{.ID}} | {{.Names}}')
    echo "Running Containers:"
    echo "$en_conInfo"

    #user input
    read -p "Enter the name or ID of the container you want to stop: " di_conName

    #stop container 
    docker stop "$di_conName"

    exit 1
fi

#build images yes
if [[ $en_imgBuild -eq 1 ]] ; then
    echo "What image name would you like to use for Nextcloud?"
    read -r -p "Input: " nc_name ;

    echo "What would you like to name this Nextcloud version?"
    read -r -p "Input: " nc_version ;

    docker build -t "$nc_name:$nc_version" ./nc

    echo "What image name would you like to use for MariaDB?"
    read -r -p "Input: " db_name ;

    echo "What would you like to name this MariaDB version?"
    read -r -p "Input: " db_version ;

    docker build -t "$db_name:$db_version" ./db

    nc_image="$nc_name:$nc_version"
    db_image="$db_name:$db_version"

    #set custom directory name
    echo "Do you want to set a custom directory for your Container Volumes?"
    echo "Default folder is: /$dir_name/*"
    echo "1. Yes"
    echo "2. No"
    read -r -p "Input: " en_dirName ;

    if [[ $en_dirName -eq 1 ]] ; then
        echo "What would you like to name your custom directory?"
        read -r -p "Input: " dir_name ;
    fi
fi

#if any folders missing create them
if [[ ! -d "/${dir_name}" ]] ; then
    echo "Info: Custom Directory does not exist. Creating it..."
    mkdir "/${dir_name}"
fi

#run only 1 of the containers
en_conSingle=0

echo "Do you want to start a single container or both?"
echo "1. Single"
echo "2. Both (Default)"
read -r -p "Input: " en_conSingle ;

if [[ $en_conSingle -eq 1 ]] ; then
    echo "Which container would you like to start?"
    echo "1. MariaDB"
    echo "2. Nextcloud (Default)"
    read -r -p "Input: "  en_conSingleChoice ;
    if [[ $en_conSingleChoice -eq 1 ]] ; then
        nc_on=0
    else
        db_on=0
    fi
fi

#run default or custom name for NC
en_conName=0

if [[ $nc_on -eq 1 ]] ; then
    echo "Do you want to use custom container name for NEXTCLOUD?"
    echo "Standard names are: '$nc_conName' and '$db_conName'"
    echo "1. Custom"
    echo "2. Standard (Default)"
    read -r -p "Input: " en_conName ;

    if [[ $en_conName -eq 1 ]] ; then
        echo "What would you like to name your custom container for NEXTCLOUD?"
        read -r -p "Input: " nc_conName ;
    fi
fi

#run each container
if [[ $db_on -eq 1 ]] ; then
    #echo "db_on"
    docker run -d --name "$db_conName" --volume /$dir_name/mariadb:/var/lib/mysql $db_image
fi
if [[ $nc_on -eq 1 ]] ; then
    #echo "nc_on"
    docker run -d --name "$nc_conName" -p "$nc_port":80 --link "$db_conName":"$db_conName" --volume /$dir_name/$nc_volRoot:/var/www/html --volume /$dir_name/$nc_volData:/var/www/html/data --volume /$dir_name/$nc_volConf:/var/www/html/config $nc_image
fi

echo "Nextcloud '$nc_conName' using image '$nc_image' available at: http://localhost:$nc_port"
