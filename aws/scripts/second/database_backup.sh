#!/bin/bash
mysqldump -h remote_host -u admin_username -p wordpress > wordpress_backup.sql
