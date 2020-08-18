#! /usr/bin/bash

# This shell script contains the function required for computing check_sys.sh
#
# Author: Shaik Faizan Roshan Ali 
#
# Email: alashercoder@gmail.com


function bucketize() {

#arranging them in buckets
used_percent=`df -kh | awk 'NR>1{print $5}'| sed 's/%//g'`

for percent_value in $used_percent
do
    if [ "$percent_value" -ge "0" ] && [ "$percent_value" -le "40" ]
    then
        bucket+=(green)
    elif [ "$percent_value" -gt "40" ] && [ "$percent_value" -le "75" ]
    then
        bucket+=(yellow)
    elif [ "$percent_value" -gt "75" ] && [ "$percent_value" -le "100" ]
    then
        bucket+=(red)
    else
        echo "error"
    fi  
done

}

function backup(){
    #backup_path=/home/Faizan
    #backup=`tar -czfv backup.tar.gz $backup_path /home/Faizan/backup`
    echo "currently not functioning"
}
