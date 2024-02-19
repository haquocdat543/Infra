#!/bin/bash

# Install Docker and Rabbitmq
sudo apt-get update
sudo apt-get install docker.io -y
sudo usermod -aG docker ubuntu
newgrp docker
sudo chmod 777 /var/run/docker.sock
docker run -d --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.12-management


