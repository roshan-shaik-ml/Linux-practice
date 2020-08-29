#! /usr/bin/bash

# This shell script output's a html file which report the disk space and warn the linux admin about the sys admin
#
# Author: Shaik Faizan Roshan Ali 
#
# Email: alashercoder@gmail.com
source report_lib.sh
source users.sh
source disk_usage_check.sh

bucketize "$used_percent"
echo "bucketizing" | ts >> logfile.txt

sort_color "disk_usage.csv" "$used_percent_col"
echo "sorting color" | ts >> logfile.txt

bucketize_user
echo "bucketizing user stats" | ts >> logfile.txt

check_packages
echo "checking packages complete" | ts >> logfile.txt

html_handcode

csv2html disk_usage_table.csv
csv2html user_table.csv
csv2html package_list.csv

echo "</body>" >> admin_report.html
echo "</html>" >> admin_report.html

#backup
echo "backing up the user system done" | ts >> logfile.txt
echo "process complete" | ts >> logfile.txt
