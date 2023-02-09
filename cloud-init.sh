#!/bin/bash
# R.Tavares
# 07.12.2022 v1.5.1
#
#

logfile="/var/log/cloudinit_installer_rta.log"
delimiter="----------------------------------------------"
runtimeStart=$(date +%s%N)

echo -e "logfile=$logfile\ndelimiter=$delimiter\nruntimeStart=$runtimeStart" >> $logfile
clear

#displayed on screen and log
echo -e "$delimiter\nPlease wait...\n$delimiter" 2>&1 | tee -a $logfile


echo "$delimiter" >> $logfile
echo "install packages" >> $logfile
echo "$delimiter" >> $logfile
sudo apt-get update >> $logfile
echo "$delimiter" >> $logfile
sudo apt-get install openjdk-18-jdk maven ca-certificates curl gnupg lsb-release --yes >> $logfile
echo "$delimiter" >> $logfile


#run package
echo "make package and run it" >> $logfile
echo "$delimiter" >> $logfile
git clone https://gitlab.com/bbwrl/m346-ref-card-03.git >> $logfile 2>&1
echo "$delimiter" >> $logfile
cd m346-ref-card-03

sudo docker compose up --detach >> $logfile 2>&1
echo "$delimiter" >> $logfile
sudo mvn package >> $logfile
echo "$delimiter" >> $logfile
sudo java -DDB_USERNAME='jokedbuser' -DDB_PASSWORD='123456' -jar target/architecture-refcard-03-0.0.1-SNAPSHOT.jar >> $logfile 2>&1 &


#displayed on screen and log
echo -e "$delimiter\nScript finished.\n$delimiter\nSee Log at: '$logfile'\n$delimiter" 2>&1 | tee -a $logfile



runtimeEnd=$(date +%s%N)
runtimeDiff=$(($runtimeEnd - $runtimeStart))
runtimeDiffSec=$(
		awk "BEGIN { print ($runtimeDiff/1000000000) }"
	)
echo -e "runtimeEnd=$runtimeEnd\n$delimiter" >> $logfile
#displayed on screen and log
echo -e "${runtimeDiffSec}s elapsed.\n$delimiter" 2>&1 | tee -a $logfile
