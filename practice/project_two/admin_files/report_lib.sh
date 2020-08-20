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

function sort_color() {
`cat admin_report.csv | sort -k 3 > admin_report_sorted.csv`
_file_paths_=`awk -F "," '{print $1}' admin_report_sorted.csv`
_buckets_=`awk -F "," '{print $2}' admin_report_sorted.csv`
_used_percents_=`awk -F "," '{print $3}' admin_report_sorted.csv`    
_space_available_=`awk -F "," '{print $4}' admin_report_sorted.csv`

for filepath in $_file_paths_
do
    file_path_arr+=($filepath)
done

for bucket in $_buckets_
do
    bucket_arr+=($bucket)
done

for usedpercent in $_used_percents_
do
    used_percent_arr+=($usedpercent)
done

for space in $_space_available_
do
    space_avail_arr+=($space)
done


}


function backup(){
    #current_directory=`pwd`
    #`cd`
    #`tar czfp /home/Faizan/backup.tar.gz /home/Faizan`
    #`cd $current_directory`
    echo "Backup function commented for testing"
}

function junk_uninstall() {
user_list=`cat /etc/passwd | awk -F ":" '{if($3>=1000){print $1}}' | grep -vi "nobody"`

for user in $user_list
do
    su - $user
    # installing the blacklisted package for testing
    sudo apt-get install cowsay

    echo "##########################################################################"
    echo "installing complete..."
    echo "##########################################################################"
    declare -a blacklist_app
    blacklist_apps=cowsay

    packages=`sudo dpkg-query -l`

    for package in "${blacklist_apps[@]}"
    do  
        `sudo dpkg-query -l | grep -i "$package" > /dev/null`
        echo "searching for package..."
        echo "#######################################################################"
        # $? check for the exit status of the last pipeline command
        if [ $? -eq 0 ] 
        then
            echo "Found package $package... Preparing for uninstalling"
            sudo dpkg --remove $package
            echo "$package Uninstalled sucessfully."
            echo "#######################################################################"
        elif [ $? -ne 0 ] 
        then
            echo "No blacklist pacakges are installed !!!"
        fi
    done
    `exit`
done    

}
