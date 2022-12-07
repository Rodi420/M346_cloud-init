#!/bin/bash
# R.Tavares
# 06.12.2022 v1.2
#
#

#start install docker packages
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin --yes
echo "installed successfully" >> /var/log/could-init-output.log

#attempt docker test
echo "attempting docker test" >> /var/log/could-init-output.log
sudo docker run hello-world


