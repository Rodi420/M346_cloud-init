#!/bin/bash
# R.Tavares
# 06.12.2022 v1.0
#
#

#start install docker packages
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli conteinerd.io docker-compose-plugin
echo "installed successfully" >> /etc/var/could-init-output.log

#attempt docker test
echo "attempting docker test" >> /etc/var/could-init-output.log
sudo docker run hello-world


