#!/bin/bash
# R.Tavares
# 20.12.2022 v1.0
#
#

#install packages
sudo apt-get update
sudo apt-get install openjdk-19-jdk maven --yes
echo "installed successfully" 2&>1 3&>1 1&>> /var/log/cloud-init-ref04-output.log


#make package and run it
git clone https://github.com/Rodi420/M346_jar_files
cd /home/ubuntu/M346_cloud-init/M346_jar_files/m346-ref-card-04-azure-main-edit
mvn package
sleep 2
mvn package
java -jar target/m346-ref-card-04-azure-0.0.1-SNAPSHOT.jar &

