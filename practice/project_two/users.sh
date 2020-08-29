#! /usr/bin/bash

# This scripts get the user and home directory file storage 
#
# Author: Shaik Faizan Roshan Ali
#
# Email: alsahercoder@gmail.com

source report_lib.sh

_human_users=`cat /etc/passwd | awk -F ":" '{if($3>=1000 && $3<1010){print $1}}' | grep -vi nobody`
_home_directories=`cat /etc/passwd | grep -v nobody | awk -F ":" '{if($3>=1000){print $6}}'`

user_count=`cat /etc/passwd | awk -F ":" '{if($3>=1000){print $1}}' | grep -v nobody | wc -l`

# Access the file permissions as root

for user in $_human_users
do
    human_user+=($user)
done

for directory in $_home_directories
do
    home_directory+=($directory)
done

for user in $_human_users
do
    user_usage+=(`sudo -u $user du -h /home/$user | tail -1 | awk '{print $1}'`)
done

for user in $_human_users
do
    user_bucket+=(`sudo -u $user du -b /home/$user | tail -1 | awk '{print $1}'`)
done

#Users Stats
echo "USERNAME,USER_HOME_DIRECTORY,USER_USAGE,COLOR_BUCKET" > user_table.csv
