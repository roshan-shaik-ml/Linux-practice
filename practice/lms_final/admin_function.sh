#! /usr/bin/bash


function add_book(){
	echo "addbook"
	echo "Hey Admin! what would book would you like to add."
	echo "Please enter the reference id:"
	declare -x ref_id
	read ref_id
	echo "please enter the name of the category:"
	declare -x category
	read category
	echo "Please enter the name of the book:"
	declare -x new_book
	read new_book
	echo "Please enter the name of the author:"
	decalre -x author_name
	read author_name
	echo "$ref_id	$category  $new_book	$author_name	yes	NA	NA	NA	NA" >> libsheet1.txt
	
	

}

function check_fine() {
	echo "whoa ! some kids are reading alot."
	echo "We will let them have some fun"
	echo "======================================"
	echo "Whom would you like to check on?"
	declare -x to_check 
	read to_check
	
	declare -x issued_date
	declare -x return_date
	issued_date=`cat student.db | grep -i $to_check | awk '{print $4}'`
	return_date=`cat student.db | grep -i $to_check | awk '{print $5}'`
	echo "check_fine(): $issued_date $return_date"
	issued_days=$(./datefunction.py $issued_date $return_date)
	
	if [ $issued_days -gt 14 ] && [ $issued_days -lt 30 ] 
	then
		declare -x extra_days
		extra_days=`expr $issued_days - 14`
		fine_amount=`echo "$extra_days*0.75" | bc -l`
		echo "This kid needs to pay $fine_amount dollars"
	elif [ $issued_days -gt 30 ] 
	then
		echo "The fine for late  book return is 15 dollars"
	else 
		echo "error"
		exit
	fi
}

function report() {
	echo "report"
	echo "Hey admin! let's make a report!!!"	
	#For printing total number of books
	declare -x total_books
	echo "Lets check the total number of books."
	total_books=`awk 'NR>1{count++} END{print count}' libsheet.txt`
	echo "Would you like to look at their names to?"
	declare -x admin_request2
	read admin_request2
	echo "-------------------------------------------------------"
	if [ $admin_request2 = "yes" ]
	then 
		awk 'NR>1{print $2}' libsheet.txt
		echo "Those are alot of books!!!"
	elif [ $admin_request2 = "no" ]
	then 
		echo "Okay"
	else 
		echo "That's an unknown request"
	fi
	echo "The total number of books in the inventory are $total_books"
	echo "------------------------------------------------------------------------"
	
	# Frequency of books that has been issued in each category
	awk 'BEGIN{print "Category    Bookname"}NR>1{if($5=="no"){print $2, "    ", $3;}}' libsheet.txt
	
	#for finding which students have highest fines
	list_name=`awk'NR>1{print $2}' student.db`
	for i in $list_name
	do
	
		read $i

        	declare -x issued_date
        	declare -x return_date
        	issued_date=`cat student.db | grep -i $i | awk '{print $4}'`
        	return_date=`cat student.db | grep -i $i | awk '{print $5}'`
        		if [ $issued_date != "NA" ] && [ $return_date != "NA"]
        		then
				issued_days=$(./datefunction.py $issued_date $return_date)
				
				if [ $issued_days -gt 14 ] && [ $issued_days -lt 30 ]
        			then
                			declare -x extra_days
                			extra_days=`expr $issued_days - 14`
                			fine_amount=`echo "$extra_days*0.75" | bc -l`
                			echo -e "$i\t$fine_amount"
        			elif [ $issued_days -gt 30 ]
        			then
               					 `echo -e "$i\t15"`
				fi
			
			else
				echo "The book is not issued/ reutrned"
			
			fi
  	done		

}


