#!/bin/bash

# Install Rabbitmq
sudo apt-get update -y
sudo apt-get install -y rabbitmq-server
sudo systemctl enable rabbitmq-server
sudo systemctl start rabbitmq-server
