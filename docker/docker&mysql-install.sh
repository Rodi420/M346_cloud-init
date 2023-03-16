#!/bin/bash
# R.Tavares
# 06.12.2022 v1.6
# updated script for M169
#

logfile="/var/log/docker_installer_rta.log"
delimiter="----------------------------------------------"
runtimeStart=$(date +%s%N)

echo -e "logfile=$logfile\ndelimiter=$delimiter\nruntimeStart=$runtimeStart" >> $logfile
clear

#displayed on screen and log
echo -e "$delimiter\nPlease wait...\n$delimiter" 2>&1 | tee -a $logfile


#initial updates


echo "update packages" >> $logfile
echo "$delimiter" >> $logfile
sudo apt-get update >>$logfile
echo "$delimiter" >> $logfile
sudo apt-get install ca-certificates curl gnupg lsb-release --yes >> $logfile
echo "$delimiter" >> $logfile

#prepare docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg 
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.gpg

#install docker packages
echo "start install docker packages" >>$logfile
echo "$delimiter" >> $logfile
sudo apt-get update >> $logfile
echo "$delimiter" >> $logfile
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin --yes >> $logfile
echo "$delimiter" >> $logfile

#test attempt
echo "attempt docker test" >> $logfile
echo "$delimiter" >> $logfile
sudo docker run hello-world >> $logfile 2>&1
echo -e "$delimiter\nDocker Installed.\n$delimiter" 2>&1 | tee -a $logfile


echo -e "$delimiter\nStarting MySQL & PhpMyAdmin.\n$delimiter" 2>&1 | tee -a $logfile
sudo docker compose up --detach >> $logfile 2>&1

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

