#!/bin/bash
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
echo
read -p "Please enter your Wordpress admin username: " wpusername
read -sp "Please enter your Wordpress admin password: " wppassword

# Check if the database exists
DB_EXISTS=$(mysql -h $dbendpoint -u $dbusername -p$dbpassword -e "SHOW DATABASES LIKE 'wordpress';" | grep "wordpress")

# If the database does not exist, create it
if [ -z "$DB_EXISTS" ]; then
    mysql -h $dbendpoint -u $dbusername -p$dbpassword -e "CREATE DATABASE wordpress;"
    echo "Database 'wordpress' created successfully."
else
    echo "Database 'wordpress' already exists."
fi

cd /var/www/html
wp config create --dbhost="$dbendpoint" --dbname="wordpress" --dbuser="$dbusername" --dbpass="$dbpassword"
wp core install --url="$domain" --title="Test Wordpress Page" --admin_user="$wpusername" --admin_password="$wppassword" --admin_email="admin@example.com"
