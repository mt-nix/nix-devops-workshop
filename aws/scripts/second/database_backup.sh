#!/bin/bash
mkdir -p /backup

current_date_time=$(date +"%d_%m_%y_%H_%M")
filename="/backup/mysql_backup_${current_date_time}.sql"

read -p "S3 bucket name: " s3_bucket
read -p "RDS database endpoint: " endpoint
read -p "MySQL admin username: " adminuser
read -sp "MySQL admin password: " adminpw

mysqldump -h "$endpoint" -u "$adminuser" -p"$adminpw" wordpress > $filename
aws s3 cp $file_path s3://$s3_bucket/
