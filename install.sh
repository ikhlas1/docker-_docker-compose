#!/bin/bash

#Uninstall old versions
sudo apt-get remove docker docker-engine docker.io containerd runc

#Update the apt package index and install packages 

#to allow apt to use a repository over HTTPS:
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

#Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

#Set stable repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#Install Docker Engine and containerd latest
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

#Execute docker as non-root
sudo usermod -aG docker $USER
newgrp docker

#Download latest stable Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

#Make it executable
sudo chmod +x /usr/local/bin/docker-compose
