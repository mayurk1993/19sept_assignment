!/bin/bash

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl start docker
sudo systemctl status docker

sudo docker pull jenkins/jenkins
sudo docker run -itd -p 8080:8080 jenkins/jenkins