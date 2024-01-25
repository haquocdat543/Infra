#!/bin/bash

sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

sudo apt install nginx-mod-stream -y

cat <<EOF | sudo tee -a /etc/nginx/nginx.conf
stream {
    upstream kubernetes {
        server master1:6443 max_fails=3 fail_timeout=30s;
        server master2:6443 max_fails=3 fail_timeout=30s;
    }
server {
        listen 6443;
        listen 8080;
        proxy_pass kubernetes;
    }
}
EOF


