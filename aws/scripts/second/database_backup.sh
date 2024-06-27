#!/bin/bash
mkdir -p /home/ubuntu/backup

current_date_time=$(date +"%d_%m_%y_%H_%M")
filename="/home/ubuntu/backup/mysql_backup_${current_date_time}.sql"

read -p "Please enter your S3 bucket name: " s3_bucket
read -p "Please enter your RDS database endpoint: " endpoint
read -p "Please enter your MySQL admin username: " adminuser
read -sp "Please enter your MySQL admin password: " adminpw
echo

mysqldump -h "$endpoint" -u "$adminuser" -p"$adminpw" wordpress > $filename
aws s3 cp $filename s3://$s3_bucket/
