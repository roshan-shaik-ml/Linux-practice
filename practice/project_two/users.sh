#! /usr/bin/bash

# This scripts get the user and home directory file storage 
#
# Author: Shaik Faizan Roshan Ali
#
# Email: alsahercoder@gmail.com

_human_users=`cat /etc/passwd | awk -F ":" '{if($3>=1000 && $3<1010){print $1}}' | grep -vi nobody`
_home_directories=`cat /etc/passwd | grep -v nobody | awk -F ":" '{if($3>=1000){print $6}}'`

user_count=`cat /etc/passwd | awk -F ":" '{if($3>1000){print $1}}' | grep -v nobody | wc -l`

# Access the file permissions as root
sudo -i

for user in $_human_users
do
    human_user+=($user)
done

for directory in $_home_directories
do
    home_directory+=($directory)
done

for usage in $_home_directories
do
    user_usage+=(`du -kh $usage | tail -1 | awk '{print $1}'`)
done

function bucketize_user() {
    
    for file_usage in $user_usage
    do
	if [ "$file_usage" -ge "0" ] && [ "$file_usage" -le "20" ]
	then
	    user_bucket+=(green)
	elif [ "$file_usage" -gt "40" ] && [ "$file_usage" -le "60" ]
	then
	    user_bucket+=(yellow)
	elif [ "$file_usage" -gt "60" ] && [ "$file_usage" -le "100" ]
	then
	    user_bucket+=(red)
	else
	    echo "Error"
	fi
    done
    
}

# html handcode 
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
echo "There are $user_count users on the system."
echo "<table>"

echo "<th>Username</th>"
echo "<th>User Home Directory</th>"
echo "<th>User Usage</th>"
echo "<th>User Bucket</th>"

for ((index_val=0; index_val<$user_count; index_val++))
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
    
    echo "<td>"
    echo "${user_bucket[$index_val]}"
    echo "</td>"
    
    echo "</tr>"
done

    echo "</table>"
echo "</html>"

#..............................................................................#


