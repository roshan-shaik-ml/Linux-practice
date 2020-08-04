#! /usr/bin/bash

source admin_function.sh

echo "Hello, admin! what would you like to do today?"
echo "1. Add a book to the inventory"
echo "2. Check fine on students"
echo "3. Get a book Report on inventory "
echo "=============================================="
echo "Please enter your option number:"
declare -x admin_request
read admin_request


if [ $admin_request = "1" ]
then
        add_book
elif [ $admin_request = "2" ]
then
        check_fine
elif [ $admin_request = "3" ]
then
        report
else
        echo "There is some error with your reequest. We can add that request in the future if you want :)"

fi
