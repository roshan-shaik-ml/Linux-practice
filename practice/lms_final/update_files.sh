#! /usr/bin/bash

function update() {
	
	# issue_date_new refers to the new values updated in libsheet after check in and check out
	issue_date_new=`cat libsheet.txt | awk 'NR>1{print $6}'`

       	for i in $issue_date_new
	do 
		ref_number=`cat libsheet.txt | awk 'NR>1{print $1}'`
		issue_date_old=`cat student.db | grep -i $ref_number | awk '{print $4}'`
		sed 's/$issue_date_old/$issue_date_new'		
	done
	
	return_date_new=`cat libsheet.txt | grep -i 1 | awk '{print $7}'`
	for j in $return_date_one
	do
		ref_number=`cat linsheet.txt | awk 'NR>1{print $1}'`
		old_return_date=`cat student.db | grep -i $ref_number | akw 'print $5'`
		sed 's/$return_date_old/$return_date_new'
	done
}

update
