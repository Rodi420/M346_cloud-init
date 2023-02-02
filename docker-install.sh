#!/bin/bash
# R.Tavares
# 06.12.2022 v1.3
# updated script for M169
#

logfile="/var/log/docker_installer_rta.log"
delimiter="----------------------------------------------"

echo "$delimiter" >> $logfile
sudo apt-get update >>$logfile
echo "$delimiter" >> $logfile
sudo apt-get install ca-certificates curl gnupg lsb-release --yes >> $logfile

#prepare docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.gpg


#start install docker packages
echo "$delimiter" >> $logfile
sudo apt-get update >> $logfile
echo "$delimiter" >> $logfile
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin --yes >> $logfile

#attempt docker test
echo "$delimiter" >> $logfile
sudo docker run hello-world >> $logfile
echo "$delimiter" >> $logfile


