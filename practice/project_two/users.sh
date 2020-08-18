#! /usr/bin/bash

#This scripts get the user and home directory file storage 
#
#Author: Shaik Faizan Roshan Ali
#
#Email: alsahercoder@gmail.com

_human_user=`cat user_data.txt | awk -F ":" '{if($3>=1000 && $3<1010){print $1}}'`
_home_directory=`cat user_data.txt | awk -F ":" '{if($3>=1000 && $3<1010){print $6}}'`

for user in $_human_user
do
    human_user+=($user)
done

for directory in $_home_directory
do
    home_directory+=($directory)
done

for usage in $_home_directory
do
    user_usage+=(`du -kh $usage | tail -1 | awk '{print $1}'`)
done

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
echo "<h1>User stats</h1>"

echo "<table>"

echo "<th>Username</th>"
echo "<th>User Home Directory</th>"
echo "<th>User Usage</th>"
for ((index_val=0; index_val<2; index_val++))
do
    echo "<tr>"

    echo "<td>"
    echo "${human_user[$index_val]}"
    echo "</td>"

    echo "<td>"
    echo "${home_directory[$index_val]}"
    echo "</td>"
    
    echo "<td>"
    echo "${user_usage[$index_val]}"
    echo "</td>"
    
    echo "</tr>"
done

    echo "</table>"
echo "</html>"
