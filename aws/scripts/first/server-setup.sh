#!/bin/bash
apt install nginx -y
rm /etc/nginx/sites-available/default
curl -L -o /etc/nginx/sites-available/default "https://raw.githubusercontent.com/mt-nix/nix-devops-workshop/main/aws/files/first/default"
rm -rf /var/www/html
mkdir /var/www/html
curl -L -o /var/www/html/index.html "https://raw.githubusercontent.com/mt-nix/nix-devops-workshop/main/aws/files/first/index.html"
curl -L -o /var/www/html/surprise.gif "https://media.tenor.com/rI_0O_9AJ5sAAAAj/nyan-cat-poptart-cat.gif"
systemctl restart nginx 
