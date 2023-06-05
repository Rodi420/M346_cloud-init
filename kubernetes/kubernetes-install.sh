#!/bin/bash
# R.Tavares
# 06.12.2022 v1.10.1
# 
#

#variables
  #EDITABLE
logfile="/var/log/kubernetes_installer_rta.log"
delimiter="--------------------------------------------------------------------------------------------"
  #DO NOT EDIT
runtimeStart=$(date +%s%N)
errorCode=0
proxyOn=1


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


#prepare minikube
sudo curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo chmod +x minikube
sudo cp minikube /usr/local/bin && rm minikube
sudo chmod +x /usr/local/bin/minikube



#install kubectl
echo "start install docker packages"
echo "$delimiter"
sudo apt-get update 
echo "$delimiter" 
sudo apt-get install -y apt-transport-https
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmour -o /usr/share/keyrings/kubernetes.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/kubernetes.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
echo "$delimiter"
sudo apt-get update 
echo "$delimiter" 
sudo apt-get install -y kubectl
echo "$delimiter"  


#start minikube
minikube start --force --driver=docker

#install minikube addons
minikube addons enable ingress
minikube addons enable dashboard
minikube addons enable metrics-server






} >> "$logfile"

#displayed on screen and log
  #script end 
echo -e "$delimiter\nScript finished.\n$delimiter\nTo start Kubernetes Dashboard run 'minikube dashboard --url'\n$delimiter\nSee Log at: '$logfile'\n$delimiter" 2>&1 | tee -a $logfile
if [[ $proxyOn -eq 1 ]]
then
  echo -e "To start the Proxy to access the Dashboard from outside of this client run:\n$delimiter\n'kubectl proxy --address='0.0.0.0' --disable-filter=true'\n$delimiter" 2>&1 | tee -a $logfile
fi
#math stuff idk
runtimeEnd=$(date +%s%N)
runtimeDiff=$(($runtimeEnd - $runtimeStart))
runtimeDiffSec=$(
		awk "BEGIN { print ($runtimeDiff/1000000000) }"
	)
echo -e "runtimeEnd=$runtimeEnd\n$delimiter" >> $logfile

#displayed on screen and log
  #display elapsed time
echo -e "\n$delimiter\n${runtimeDiffSec}s elapsed.\n$delimiter" 2>&1 | tee -a $logfile
