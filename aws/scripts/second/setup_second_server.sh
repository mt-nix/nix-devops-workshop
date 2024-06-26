#!/bin/bash
    read -p "Please enter the DB endpoint: " dbendpoint
    read -p "Please enter your DB admin username: " dbusername
    read -sp "Please enter your DB admin password: " dbpassword
    echo

    cd /var/www/html
    wp config create --dbhost="$dbendpoint" --dbname="wordpress" --dbuser="$dbusername" --dbpass="$dbpassword"
