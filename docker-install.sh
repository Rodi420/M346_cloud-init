#!/bin/bash
# R.Tavares
# 06.12.2022 v1.4
# updated script for M169
#

logfile="/var/log/docker_installer_rta.log"
delimiter="----------------------------------------------"

#initial updates
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
sudo docker run hello-world >> $logfile
echo "$delimiter" >> $logfile


