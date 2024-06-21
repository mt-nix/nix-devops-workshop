#!/bin/bash
apt install nginx
rm /etc/nginx/sites-available/default
curl -L -o /etc/nginx/sites-available/default "https://drive.google.com/u/0/uc?id=1OjKQs-tgNkklHJ7sFDN8g1h5Aa2GgN7Y&export=download"
rm -rf /var/www/html
mkdir /var/www/html
curl -L -o /var/www/html/index.html "https://drive.google.com/u/0/uc?id=1Hg1L14hF9D_vYuIIXrLfZkVQeT8NSHFY&export=download"
systemctl restart nginx 
