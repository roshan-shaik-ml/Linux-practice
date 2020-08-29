#! /usr/bin/bash

# This shell script output's a html file which report the disk space and warn the linux admin about the sys admin
#
# Author: Shaik Faizan Roshan Ali 
#
# Email: alashercoder@gmail.com
source report_lib.sh

files_paths=`df -kh | awk 'NR>1{print $1}'`
size_of_dirs=`df -kh | awk 'NR>1{print $2}'`
files_used_mem=`df -kh | awk 'NR>1{print $3}'`
avail_memory=`df -kh | awk 'NR>1{print $4}'`
declare -x used_percent=`df -kh | awk 'NR>1{print $5}'| sed 's/%//g'`
row_count=`df -kh | awk 'NR>1{print $1}' | wc -l`

for file_path in $files_paths
do
    sys_file+=($file_path)
done

for percent in $used_percent
do
    percent_val+=($percent)
done

declare -x used_percent_col=3

for avail_mem in $avail_memory
do
    avail_space+=($avail_mem)
done

declare -x used_percent_col=3

bucketize "$used_percent"

used_percent_col=3

rm disk_usage.csv

for((index=0;index<$row_count;index++))
do
    `echo "${sys_file[$index]},${bucket[$index]},${percent_val[$index]},${avail_space[$index]}" >> disk_usage.csv`
done
