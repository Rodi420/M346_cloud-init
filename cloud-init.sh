#!/bin/bash
# R.Tavares
# 07.12.2022 v1.0
#
#

#start install packages
sudo apt-get update
sudo apt-get install openjdk-18-jdk maven ca-certificates curl gnupg lsb-release --yes
echo "installed successfully" >> /var/log/could-init-output.log

#prepare docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
'deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable' | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.gpg

#start install docker packages
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin --yes
echo "installed successfully" >> /var/log/could-init-output.log

#attempt docker test
echo "attempting docker test" >> /var/log/could-init-output.log
sudo docker run hello-world

#make package and run it
git clone https://gitlab.com/bbwrl/m346-ref-card-03.git
cd m346-ref-card-03
sudo docker compose up --detach
mvn package
java -DDB_USERNAME='jokedbuser' -DDB_PASSWORD='123456' -jar target/architecture-refcard-03-0.0.1-SNAPSHOT.jar &
