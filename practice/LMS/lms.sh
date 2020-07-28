#! /usr/bin/bash

# Welcome and taking the request
echo "		Welcome to the Shell Library."
echo "======================================================"
echo "We have a wide range of Books."
echo "Please enter your name:"
read student_name
echo "please enter your student-id:"
read student_id
echo "Hello $student_name hope you are having great day."
echo "======================================================"
echo "what would you like to do today? (please enter the number of your request)"
echo "1.Check in a book"
echo "2.Checkout a book"
echo "3.Check your favourite book availabilty"
read request

#function for checking out a book
function available{
available=`awk '{print $4}' $1`
if [ $available="yes" ]
then 
	echo "The book you requested is available"
elif [ $available="no" ]
then 
	echo "The book you ordered is not available"
else
	echo "System error, will contact you as soon as it is available"
}

#this following function helps customers to check in
function check_in{
}

#This following function helps
function check_out{	
if(available="yes")
then
	sed 's/'	

}

if [ $request="1" ]
then
	$available
	if [ $available="yes" ]
	then 	
		$check_in
	elif [ $available="no" ]
	then
		echo "Sorry, the book you requested is out with some amazing reader like you."
		echo "We will notify you once we get it"
	else
		echo "Sorry, there is some trouble. Please do check some other alternatives. We must be having them."
	fi
elif [ $request="2" ]
then 
	$check_out
elif [ $request="3" ]
then 
	$available 
else 
	echo "Request unknown"
fi

