#!/bin/bash
first_server_setup() {
    echo "Setting up the first web server..."
    sudo -u ubuntu -i -- bash -c './setup_first_server.sh'
}

second_server_setup() {
    echo "Setting up the second web server..."
    sudo -u ubuntu -i -- bash -c './setup_second_server.sh'
}

mkdir /cert
mkdir -p /var/www/html
chown ubuntu:ubuntu /var/www/html
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

apt install mysql-client-core-8.0 -y

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

sudo -u ubuntu -i -- bash -c 'cd /var/www/html && wp core download'

while true; do
    read -p "Is it the first server you run this script on? Please answer with YES, or NO: " input

    input=$(echo "$input" | tr '[:lower:]' '[:upper:]')

    if [ "$input" == "YES" ]; then
        curl -L -o /home/ubuntu/setup_first_server.sh "https://raw.githubusercontent.com/mt-nix/nix-devops-workshop/main/aws/scripts/second/setup_first_server.sh"
        first_server_setup
        break
    elif [ "$input" == "NO" ]; then
        curl -L -o /home/ubuntu/setup_second_server.sh "https://raw.githubusercontent.com/mt-nix/nix-devops-workshop/main/aws/scripts/second/setup_second_server.sh"
        second_server_setup
        break
    else
        echo "Please enter either YES or NO."
    fi
done

sudo chown www-data:www-data /var/www/html -R
sudo systemctl restart nginx
sudo systemctl restart php8.3-fpm
