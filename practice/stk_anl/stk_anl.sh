#! /usr/bin/bash

function std_deviation() {
    declare numerator_term=0
    declare numerator_term_squ=0
    declare summation_value=0
        
    for closed_values in $daily_adj_closed  
    do  
	numerator_term=`echo "$closed_values-$monthly_avg_closed" | bc -l`
	numerator_term_squ=`echo "$numerator_term^2" | bc -l`
	summation_value=`echo $summation_value+$numerator_term_squ | bc -l`
    done
        standard_deviation=`echo "sqrt($summation_value/$num_days_traded)" | bc -l` 
        echo  "$standard_deviation $summation_value"
        echo "$year-$month,$standard_deviation" >> std_deviation.csv
}



function monthly_avg() {
    
    daily_adj_closed=`cat $1 | grep -i "$year-$month" | awk -F "," 'NR>1{print $6}'`
    num_days_traded=`cat $1 | grep -i "$year-$month" | awk -F "," 'NR>1{print $6}' | wc -l`
    adj_closed_sum=0    
    adj_closed_sum=`echo $daily_adj_closed | tr ' ' '+' | bc -l`
   
    declare -x monthly_avg_closed=`echo "$adj_closed_sum/$num_days_traded" | bc -l`
    echo "$year-$month,$monthly_avg_closed" >> plot_$company.csv
    
    std_deviation
}


function name_of_month() {
    
    month_arr+=(0)
    month_arr+=("January" "Febuary" "March" "April" "May" "June" "July" "August" "September" "Otober" "November" "December" )
    
}

filename=$1
start_date=$2
end_date=$3
declare -x company=$4

rm plot_$company.csv
rm std_deviation.csv
# Date format is YYYY-MM-DD
start_month=`echo $start_date | cut -f2 -d "-"`
start_year=`echo $start_date | cut -f1 -d "-"`

end_month=`echo $end_date | cut -f2 -d "-"`
end_year=`echo $end_date | cut -f1 -d "-"`

year=`echo $start_year`
month=`echo $start_month`

while [ $year -le $end_year ]
do
    if [ $month -ne $end_month ] || [ $year -ne $end_year ] 
    then
	if [ $month -le 12 ]
	then
	    monthly_avg $filename
	    month=`expr $month + 1`
	    month=`printf "%2g" "$month" | sed 's/ /0/'`
	else
	    month=`echo 01`
	    year=`expr $year + 1`
        fi
    else 
	exit
    fi
done
