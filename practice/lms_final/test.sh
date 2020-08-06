#! /usr/bin/bash

function check() {
	issue_date_one=`cat libsheet.txt | awk '{print $6}'`
        for i in $issue_date_one
        do	
		echo "$i"
	done
}
check
