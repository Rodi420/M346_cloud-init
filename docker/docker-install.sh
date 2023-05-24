#!/bin/bash
# R.Tavares
# 06.12.2022 v1.9
# updated script for M169
#

#variables
  #EDITABLE
logfile="/var/log/docker_installer_rta.log"
delimiter="----------------------------------------------"
  #DO NOT EDIT
runtimeStart=$(date +%s%N)
errorCode=0

#check for sudo privileges 
if [ "$EUID" -ne 0 ]; then
  errorCode=1
  echo -e "$delimiter\nError $errorCode: Permissions not found. Please run with sudo enabled.\n$delimiter"
  exit
fi
echo -e "$delimiter\npermissions found. resume script...\n$delimiter" >> $logfile

#print variables to log
echo -e "logfile=$logfile\ndelimiter=$delimiter\nruntimeStart=$runtimeStart" >> $logfile

#clear the screen
clear

#displayed on screen and log
echo -e "$delimiter\nPlease wait...\n$delimiter" 2>&1 | tee -a $logfile

#initial updates
{
echo "update packages" 
echo "$delimiter" 
sudo apt-get update 
echo "$delimiter" 
sudo apt-get install ca-certificates curl gnupg lsb-release --yes 
echo "$delimiter" 
} >> "$logfile"

#prepare docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg 
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.gpg

{ 
#install docker packages
echo "start install docker packages"
echo "$delimiter"
sudo apt-get update 
echo "$delimiter" 
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin --yes
echo "$delimiter" 

#add docker group
echo "creating docker user group"
echo "$delimiter" 
newgrp docker
sudo usermod -aG docker "$USER"
echo "created docker user group"
echo "$delimiter" 


#test docker functionality
echo "attempt docker test" >> $logfile
echo "$delimiter" >> $logfile
} >> "$logfile"
docker run hello-world >> $logfile 2>&1


#displayed on screen and log
  #script end 
echo -e "$delimiter\nScript finished.\n$delimiter\nSee Log at: '$logfile'\n$delimiter" 2>&1 | tee -a $logfile

#math stuff idk
runtimeEnd=$(date +%s%N)
runtimeDiff=$(($runtimeEnd - $runtimeStart))
runtimeDiffSec=$(
		awk "BEGIN { print ($runtimeDiff/1000000000) }"
	)
echo -e "runtimeEnd=$runtimeEnd\n$delimiter" >> $logfile

#displayed on screen and log
  #display elapsed time
echo -e "$delimiter\n${runtimeDiffSec}s elapsed.\n$delimiter" 2>&1 | tee -a $logfile
