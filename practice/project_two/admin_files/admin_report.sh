#! /usr/bin/bash

# This shell script output's a html file which report the disk space and warn the linux admin about the sys admin
#
# Author: Shaik Faizan Roshan Ali 
#
# Email: alashercoder@gmail.com

source users.sh
source report_lib.sh
#......................................................................#

files_paths=`df -kh | awk 'NR>1{print $1}'`
size_of_dirs=`df -kh | awk 'NR>1{print $2}'`
files_used_mem=`df -kh | awk 'NR>1{print $3}'`
avail_memory=`df -kh | awk 'NR>1{print $4}'`
used_percent=`df -kh | awk 'NR>1{print $5}'| sed 's/%//g'`
row_count=`df -kh | awk 'NR>1{print $1}' | wc -l`

bucketize
echo "bucketizing" | ts >> logfile.txt

for file_path in $files_paths
do
    sys_file+=($file_path)
done

for percent in $used_percent
do
    percent_val+=($percent)
done

for avail_mem in $avail_memory
do
    avail_space+=($avail_mem)
done

#----------Sorting--------------------------------------------#
rm admin_report.csv
for((index=0;index<$row_count;index++))
do
    `echo "${sys_file[$index]},${bucket[$index]},${percent_val[$index]},${avail_space[$index]}" >> admin_report.csv`
done

sort_color 
echo "sorting color" | ts >> logfile.txt

#..............................................................#
junk_uninstall
echo "checking blacklisting packages done" | ts >> logfile.txt
#---------------------------------------------------------------#
bucketize_user
echo "bucketizing user stats" | ts >> logfile.txt
#---------------------------------------------------------------#
check_packages
echo "checking packages complete" | ts >> logfile.txt
#Disk Usage of the System
echo "FILE_PATH,COLOR_BUCKET,USED_PERCENTAGE,AVAILABLE,HISTOGRAM">table1.csv

for ((index_val=0; index_val<$row_count; index_val++))
do
    echo "${file_path_arr[$index_val]},${bucket_arr[$index_val]},${used_percent_arr[$index_val]},${space_avail_arr[$index_val]}" >> table1.csv
done

#Users Stats
echo "There are $user_count users on the system."

echo "USERNAME,USER_HOME_DIRECTORY,USER_USAGE,COLOR_BUCKET">table2.csv

for ((index_value=0; index_value<$user_count; index_value++))
do

    echo "${human_user[$index_value]},${home_directory[$index_value]},${user_usage[$index_value]},${user_bucketize[$index_value]}">>table2.csv
done

#Top 5 packages consuming more space

echo "PACKAGE_NAME,OCCUPIED_MEMORY"> table3.csv

for ((rows=0; rows<6; rows++))
do	
    echo "${most_occupied[$rows]},${space_occupied[$rows]}" >>table3.csv
done

#-------------making--it--to--html--------------#

html_handcode
csv2html
echo "</body>" >> admin_report.html
echo "</html>" >> admin_report.html
    
#backup
echo "backing up the user system done" | ts >> logfile.txt
echo "process complete" | ts >> logfile.txt
echo "process done"
