#!/bin/bash
# R.Tavares
# 07.12.2022 v1.4
#
#

logfile="/var/log/docker_installer_rta.log"
delimiter="----------------------------------------------"

echo "$delimiter" >> $logfile
echo "install packages" >> $logfile
echo "$delimiter" >> $logfile
sudo apt-get update
echo "$delimiter" >> $logfile
sudo apt-get install openjdk-18-jdk maven ca-certificates curl gnupg lsb-release --yes >> $logfile
echo "$delimiter" >> $logfile

#prepare docker
#sudo mkdir -p /etc/apt/keyrings
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#echo \
#  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#sudo chmod a+r /etc/apt/keyrings/docker.gpg

#start install docker packages
#sudo apt-get update
#sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin --yes
#echo "installed successfully" >> /var/log/could-init-output.log

#attempt docker test
#echo "attempting docker test" >> /var/log/could-init-output.log
#sudo docker run hello-world

#run package
echo "make package and run it" >> $logfile
echo "$delimiter" >> $logfile
git clone https://gitlab.com/bbwrl/m346-ref-card-03.git >> $logfile
echo "$delimiter" >> $logfile
cd m346-ref-card-03
echo "$delimiter" >> $logfile
sudo docker compose up --detach >> $logfile
echo "$delimiter" >> $logfile
sudo mvn package >> $logfile
echo "$delimiter" >> $logfile
sudo java -DDB_USERNAME='jokedbuser' -DDB_PASSWORD='123456' -jar target/architecture-refcard-03-0.0.1-SNAPSHOT.jar & >> $logfile
echo "$delimiter" >> $logfile