#!/bin/bash
# R.Tavares
# 06.12.2022 v1.5
# updated script for M169
#

logfile="/var/log/docker_installer_rta.log"
delimiter="----------------------------------------------"
runtimeStart=$(date +%s%N)
clear

#initial updates
echo "$delimiter"
echo "Please wait..."
echo "$delimiter"

echo "$delimiter" >> $logfile
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
echo "$delimiter" >> $logfile

echo "$delimiter"
echo "Script finished."
echo "$delimiter"

runtimeEnd=$(date +%s%N)
runtimeDiff=$(($runtimeEnd - $runtimeStart))
runtimeDiffSec=$(
		awk "BEGIN { print ($runtimeDiff/1000000000) }"
	)
echo "${runtimeDiffSec}s elapsed." 2>&1 | tee -a $logfile
echo "$delimiter" 2>&1 | tee -a $logfile
