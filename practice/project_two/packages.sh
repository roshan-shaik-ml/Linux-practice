#! /usr/bin/bash

_human_user=`cat user_data.txt | awk -F ":" '{if($3>=1000 && $3<1010){print $1}}'`

for user in $_human_user
do
    human_user+=($user)
done

package_installed=`apt list --installed | awk -F "/" '{print $1}'`

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
echo "<h1>Package installed</h1>"

echo "<ul>"
for package in $package_installed
do
	echo "<li>$package</li>"
done
echo "</ul>"
echo "</html>"
