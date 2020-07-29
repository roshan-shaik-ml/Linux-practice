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
echo "======================================================="
echo "what would you like to do today? (please enter the number of your request)"
echo "1.Check-out a book"
echo "2.Check-in a book"
echo "3.Check your favourite book availabilty"
echo "======================================================="
read request

#function for checking avaibility of a book

function check_available(){
	echo "please enter the name of your book:"
	read book_name
	available=`grep -i $book_name libsheet.txt | awk '{print $4}'`
	if [ $available="yes" ]
	then	
		echo "The book you requested is available"
	elif [ $available="no" ]
	then 
		echo "The book you ordered is not available"
	else
		echo "System error, will contact you as soon as it is available"
	fi
	exit
}


#this following function helps customers to check in
#function check_in(){
#}

#This following function helps to check out a book

function check_out(){	

	echo "Please enter the name of your book:"
	read book_name

	#calling check_available to make sure the book is available before check out
	check_available

	if [ $available="yes" ]
	then
		echo "Please enter the issue date:"
		read issue_date


		#these following lines changes the previous values with new ones. 
		prev_name=`cat libsheet.txt | grep -i book_checkout | awk '{print $8}'`
		sed 's/$prev_name/$student_name/'
		prev_date=`cat libsheet.txt | grep -i book_checkout | awk '{print $5}'`
		sed 's/$prev_date/$issuedate/'
		prev_id=`cat libsheet.txt | grep -i book_checkout | awk '{print $7}'`
		sed 's/$prev_id/$student_id'
		echo "Your details have been registered please remember to return before 14 days"
	
	elif [ $available="no" ]
	then
		echo "Sorry, the book you requested is out with some amazing reader like you."
                echo "We will notify you once we get it"
	else
		echo "Sorry, there is some trouble. Please do check some other alternatives. We must be having them."
	fi	
		
}


# processing user request by calling functions

if [ $request="1" ]
then
	check_available

elif [ $request="2" ]
then 
	check_in
elif [ $request="3" ]
then 
	check_available
else 
	echo "Request unknown"
fi

