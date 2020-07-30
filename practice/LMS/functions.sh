#! /usr/bin/bash

#function for checking avaibility of a book

function check_available(){
	echo "please enter the name of your book:"
	read book_name
	available=`grep -i $book_name libsheet.txt | awk '{print $4}'`

	if [ $available = "yes" ]
	then
		echo "The book you requested is available"
	elif [ $available = "no" ]
	then
		echo "The book you ordered is not available"
	else
		echo "System error, will contact you as soon as it is available"
	fi
	exit
}


#this following function helps customers to check in
function check_in(){
	
	check_available	
	if [ $available = "yes"]
	then
		echo "Sorry, Are you trying to checkout"
	elif [ $avaiable = "no" ]
	then
		echo "please enter today's date in dd-mm-yyyy format:"
		declare -x today_date
		read today_date
		
		return_date=`cat  libsheet.txt | grep -i $book_name | awk '{print $6}'` 
		sed 's/$return_date/$today_date/'
		prev_name=`cat libsheet.txt | grep -i $book_name | awk '{print $8}'`
		sed 's/$prev_name/NA/'
		prev_id=`cat libsheet.txt | grep -i $bookname | awk '{print $7}'`
		sed 's/$prev_id/NA'
	fi
}

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

