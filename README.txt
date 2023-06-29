# M346_cloud-init
von Rodrigo Tavares

enthält ein paar Skripts aus M346
dazu gehört ein Skript, dass Docker auf Linux installiert. (docker-install.sh)

Skripts die auf dem neusten stand sind:
docker/*
cloud-init.sh (NICHT REF03 ODER REF04)

##########################################################

BEVOR BENUTZUNG BERECHTIGUNGEN MIT "chmod -R 755 M346_cloud-init" ÄNDERN

SKRIPTS MIT "sudo" STARTEN!!!

BEI BEDARF SKRIPTS MIT "dos2unix" UMÄNDERN!!

##########################################################

docker-install braucht etwa 40sek um sich zu installieren.
cloud-init braucht etwa 200sek um vollständig zu laufen.


##########################################################
Environments
##########################################################

php-mysql:

in das Verzeichnis wechseln
$ docker compose up -d 

#############################

phpmyadmin-mariadb:

shell Skript starten
oder 
$ docker compose up -d
(im gleichen Verzeichnis)

#############################

nextcloud-mysql:

installiert nextcloud mit mariadb auf docker 
durch compose oder run befehl gestartet

mehr infos:
./docker/nextcloud-mysql/readme.txt 

#############################