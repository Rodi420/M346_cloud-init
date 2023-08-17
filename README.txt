####################################################################################################################
# M346_cloud-init v1.12.6
von Rodrigo Tavares

enthält ein paar Skripts aus M346
dazu gehört ein Skript, dass Docker auf Linux installiert. (docker-install.sh)
zusätzlich sind 4 Environments die verschiedene funktionen abdecken. (siehe unten)

Skripts die auf dem neusten stand sind:
docker/*
cloud-init.sh (NICHT REF03 ODER REF04)

sämtliche weitere README.txt sind auf Englisch.

####################################################################################################################

BEVOR BENUTZUNG BERECHTIGUNGEN MIT "chmod -R 755 M346_cloud-init" ÄNDERN

SKRIPTS MIT "sudo" STARTEN!!!

BEI BEDARF SKRIPTS MIT "dos2unix" UMÄNDERN!!

####################################################################################################################

docker-install braucht etwa 40sek um sich zu installieren.
cloud-init braucht etwa 200sek um vollständig zu laufen.

####################################################################################################################
                                                    Environments
####################################################################################################################

php-mysql: (unstabil)

installiert php-apache mit mysql verbindung 

in das Verzeichnis wechseln
$ docker compose up -d 

####################################################################################################################

phpmyadmin-mariadb: (stabil)

installiert phpmyadmin mit einer mariadb datenbank

$ cd ./docker/phpmyadmin-mariadb 
$ docker compose up -d

####################################################################################################################

nextcloud-mysql: (stabil)

installiert nextcloud mit mariadb auf docker 
durch compose oder run befehl gestartet

mehr infos:
./docker/nextcloud-mysql/readme.txt 

####################################################################################################################

php-sql-admin: (stabil)

installiert php-apache mit mariadb und phpmyadmin auf docker
durch compose befehl gestartet

mehr infos:
./docker/php-sql-admin/readme.txt 

####################################################################################################################