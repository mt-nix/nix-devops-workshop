#!/bin/bash
rm /etc/nginx/sites-available/default
curl -L -o /etc/nginx/sites-available/default "https://raw.githubusercontent.com/mt-nix/nix-devops-workshop/main/aws/files/second/default"
apt install python-software-properties -y
add-apt-repository -y ppa:ondrej/php
apt install php8.3 php8.3-fpm -y
apt install php-mysql -y
mkdir /root/Downloads
wget -P /root/Downloads https://wordpress.org/wordpress-6.5.3.tar.gz
cd /root/Downloads
tar -xf wordpress-6.5.3.tar.gz
cp /root/Downloads/wordpress/* /var/www/html -r
chown www-data:www-data /var/www/html -R
systemctl restart nginx
systemctl restart php8.3-fpm
