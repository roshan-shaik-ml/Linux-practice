#! /usr/bin/bash

# This shell script output's a html file which report the disk space and warn the linux admin about the sys admin
#
# Author: Shaik Faizan Roshan Ali 
#
# Email: alashercoder@gmail.com


function bucketize() {
#arranging them in buckets
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

#......................................................................#

# df & awk command for getting input
files_paths=`df -kh | awk 'NR>1{print $1}'`
size_of_dirs=`df -kh | awk 'NR>1{print $2}'`
files_used_mem=`df -kh | awk 'NR>1{print $3}'`
avail_memory=`df -kh | awk 'NR>1{print $4}'`
used_percent=`df -kh | awk 'NR>1{print $5}'| sed 's/%//g'`

bucketize

#loop for assigning col to array for printing them in table
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

#..............................................................#

#html handcode 
echo "<html>"
echo "<head>"
echo "<style>"
echo "table {"
echo "  font-family: arial, sans-serif;"
echo "  border-collapse: collapse;"
echo "  width: 100%;"
echo "}"
echo ""
echo "td, th {"
echo "  border: 1px solid #dddddd;"
echo "  text-align: left;"
echo "  padding: 8px;"
echo "}"
echo ""
echo "tr:nth-child(even) {"
echo "  background-color: #dddddd;"
echo "}"
echo "</style>"
echo "</head>"
echo "<h1>Admin Disk Space Management Report</h1>"
echo "<table>"
echo "<tr>"
echo "<th>FILE PATH </th>"
echo "<th>WARNING BUCKET </th>"
echo "<th>USED PERCENTANGE </th>"
echo "<th>AVAILABLE </th>"
echo "</tr>"
for ((index_val=0; index_val<18; index_val++))
do
    echo "<tr>"

    echo "<td>"
    echo "${sys_file[$index_val]}"
    echo "</td>"

    echo "<td>"
    echo "${bucket[$index_val]}"
    echo "</td>"

    echo "<td>"   
    echo "${percent_val[$index_val]}"
    echo "</td>"

    echo "<td>"
    echo "${avail_space[$index_val]}"
    echo "</td>"

    echo "</tr>"
done
echo "</table>"
echo "</html>"
