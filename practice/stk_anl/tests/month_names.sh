#! /usr/bin/bash

month+=(0)
month+=("January" "Febuary" "March" "April" "May" "June" "July" "August" "September" "Otober" "November" "December" )


months=`cat $1 | awk '{print $1}' | cut -f2 -d "-"`
for cur_month in $months
do
    set_month=`sed -i 's/$cur_month/${month[$cur_month]}' $1` 
done


