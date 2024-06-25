#!/bin/bash
mkdir /cert
cd /cert
openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr -subj "/CN=localhost"
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
rm /etc/nginx/sites-available/default
curl -L -o /etc/nginx/sites-available/default "https://raw.githubusercontent.com/mt-nix/nix-devops-workshop/main/aws/files/second/default"
apt install python-software-properties -y
add-apt-repository -y ppa:ondrej/php
apt install php8.3 php8.3-fpm -y
apt install php-mysql -y

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

read -p "Please enter your domain: " domain

if [[ $domain == https://* ]]; then
  domain="$domain"
elif [[ $domain == http://* ]]; then
  domain="https://${domain:7}"
else
  domain="https://$domain"
fi

read -p "Please enter the DB endpoint: " dbendpoint
read -p "Please enter your DB admin username: " dbusername
read -sp "Please enter your DB admin password: " dbpassword
read -p "Please enter your Wordpress admin username: " wpusername
read -sp "Please enter your Wordpress admin password: " wppassword
echo

cd /var/www/html

wp core download
wp core config --dbname="$dbendpoint" --dbuser="$dbusername" --dbpass="$dbpassword"
wp core install --url="$domain" --title="Test Wordpress Page" --admin_user="$wpusername" --admin_password="$wppassword" --admin_email="email@example.com"

chown www-data:www-data /var/www/html -R
systemctl restart nginx
systemctl restart php8.3-fpm
