#! /usr/bin/bash

# This shell script output's a html file which report the disk space and warn the linux admin about the sys admin
#
# Author: Shaik Faizan Roshan Ali 
#
# Email: alashercoder@gmail.com

source report_lib.sh
#......................................................................#

files_paths=`df -kh | awk 'NR>1{print $1}'`
size_of_dirs=`df -kh | awk 'NR>1{print $2}'`
files_used_mem=`df -kh | awk 'NR>1{print $3}'`
avail_memory=`df -kh | awk 'NR>1{print $4}'`
used_percent=`df -kh | awk 'NR>1{print $5}'| sed 's/%//g'`
row_count=`df -kh | awk 'NR>1{print $1}' | wc -l`

bucketize
backup

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
`rm admin_report.csv`
for((index=0;index<$row_count;index++))
do
    `echo "${sys_file[$index]},${bucket[$index]},${percent_val[$index]},${avail_space[$index]}" >> admin_report.csv`
done

sort_color

#..............................................................#
junk_uninstall
{
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
echo "body {"
echo "background-color: #FFF5EE;"
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
for ((index_val=0; index_val<$row_count; index_val++))
do
    echo "<tr>"

    echo "<td>"
    echo "${file_path_arr[$index_val]}"
    echo "</td>"
    
    if [ "${bucket_arr[$index_val]}" = "red" ]
    then
	echo "<td>"
	echo "<p style="color:red">red</p>"
	echo "</td>"
    elif [ "${bucket_arr[$index_val]}" = "yellow" ]
    then
        echo "<td>"
        echo "<p style="color:yellow">yellow</p>"
        echo "</td>"
    elif [ "${bucket_arr[$index_val]}" = "green" ]
    then
        echo "<td>"
        echo "<p style="color:green">green</p>"
        echo "</td>"
    else 
	echo "bucket error"
    fi

    echo "<td>"   
    echo "${used_percent_arr[$index_val]}"
    echo "</td>"

    echo "<td>"
    echo "${space_avail_arr[$index_val]}"
    echo "</td>"

    echo "</tr>"
done
echo "</table>"
echo "</body>"
echo "</html>"
} > admin_report.html
