#!/bin/sh

## Configure Linux
# Set mirrors
sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

## Setup Docker
# Installing docker script
curl -fsSL https://get.docker.com -o get-docker.sh
# Start docker script and docker service
sudo sh get-docker.sh
sudo usermod -aG docker $USER
sudo service docker start

## Build docker images
# Build busybox
sudo docker login -u dk2la -i 7355608dk2la.

sudo docker build -t vault_image .
# Build biggest image
# Run containers
# sudo docker run -i busybox_image &
# sudo docker run -i biggest_image &

