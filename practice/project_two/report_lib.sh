
# This shell script contains the function required for computing check_sys.sh
#
# Author: Shaik Faizan Roshan Ali 
#
# Email: alashercoder@gmail.com


declare -x KB=1024
declare -x MB=`expr 1024 \* 1024`
declare -x GB=`expr 1024 \* 1024 \* 1024`

top_five_mem=`dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n | tail -n 5 | awk '{print $1}'`
top_five_names=`dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n | tail -n 5 | awk '{print $2}'`

function byte_converter() {
    
    memory_values=`cat $1 | awk -v column_number=$2 -F "," 'NR>1{print $column_number}'`
   
    for memory_value in $memory_values
    do
	if [ $memory_value -le $KB ]
	then
	    human_redable+=(`echo "${memory_value}Bytes"`)
	elif [ $memory_value -gt $KB ] && [ $memory_value -le $MB ]
	then
	    storage=`expr $memory_value / $KB`
	    human_redable+=(`echo "${storage}KB"`)
	elif [ $memory_value -gt $MB ] && [ $memory_value -le $GB ]
	then
	    storage=`expr $memory_value / $MB`
	    human_redable+=(`echo "${storage}MB"`)
	else
	    storage=`expr $memory_value / $GB`
	    human_redable+=(`echo "${storage}GB"`)
	fi
    done
}


function bucketize() {

    #arranging them in buckets
    echo $1 >> error.txt
    for percent_value in $1
    do
        if [ "$percent_value" -ge "0" ] && [ "$percent_value" -le "40" ]
        then
            bucket+=(green)
        elif [ "$percent_value" -gt "40" ] && [ "$percent_value" -le "75" ]
        then
            bucket+=(yellow)
        elif [ "$percent_value" -gt "75" ] && [ "$percent_value" -le "100" ]
        then
            bucket+=(red)
        else
            echo "error"
        fi  
    done
    echo "bucktized" >> logfile.txt
}

function sort_color() {
    # arg1 is filename | arg 2 is column to be sorted // file shouldn't have headers
    old_file_name=`echo $1`
    declare -x new_file_name=`echo ${old_file_name}_sorted.csv`
    
    cat $1 | sort -k $2 > $new_file_name

    rm disk_usage_table.csv
        
    cat $new_file_name | sed -e "1 i FILE_PATH,COLOR_BUCKET,USED_PERCENTAGE,AVAILABLE,HISTOGRAM" > disk_usage_table.csv
}

function bucketize_user() {
    for ((index=0; index<$user_count; index++))
    do 
        if [ "${user_bucket[$index]}" -le  $GB ]
        then
            user_bucketize+=(green)
        elif [ "${user_bucket[$index]}" -gt $GB ]
        then 
            user_bucketize+=(red) 
        else
            echo "error"
        fi
    done

    for ((index_value=0; index_value<$user_count; index_value++))
    do

	echo "${human_user[$index_value]},${home_directory[$index_value]},${user_usage[$index_value]},${user_bucketize[$index_value]}" >> user_table.csv
    done

}

function check_packages() {
    
    for package in $top_five_names
    do
	most_occupied+=($package)
    done

    for mem in $top_five_mem
    do
	space_occupied+=($mem)
    done

    #Top 5 packages consuming more space
    echo "PACKAGE_NAME,OCCUPIED_MEMORY"> package_list.csv

    for ((rows=0; rows<6; rows++))
    do
	echo "${most_occupied[$rows]},${space_occupied[$rows]}" >> package_list.csv
    done

    byte_converter "package_list.csv" "2"
    rm package_list.csv
    
    echo "PACKAGE_NAME,OCCUPIED_MEMORY"> package_list.csv
    for ((rows=0; rows<6; rows++))
    do
        echo "${most_occupied[$rows]},${human_redable[$rows]}" >> package_list.csv
    done
}

function html_handcode() {
    {
    echo "<html>"
    echo "<head>"
    echo "<style>"
    echo "table {"
    echo "  width: 100%;"
    echo "  background-color: lemonchiffon;"
    echo "  border-collapse: collapse;"
    echo "  border-width: 2px;"
    echo "  border-color: #E2C9F8;"
    echo "  border-style: solid;"
    echo "  color: #000000;"
    echo "}" 
    echo ""
    echo " table th {"
    echo " background-color: goldenrod;"
    echo " color: white;" 
    echo "  }"
    echo "  table td, table th {"
    echo "  border-width: 2px;"
    echo "  border-color: black;"
    echo "  border-style: solid;"
    echo "  padding: 5px;"
    echo "  text-align: left;"
    echo "}" 
    echo "table {"
    echo "  background-color: lemonchiffon;"
    echo "}" 
    echo "</style>"
    echo "</head>"
    echo "<body>"
    } > admin_report.html
}

function csv2html() {

    
    column_total=`cat $1 | awk -F "," 'NR<2{print NF}'`
    row_total=`cat $1 | awk '{print $1}' | wc -l`
    
    headers=`head -n 1 $1 | tr -s ',' ' '`

    for header in $headers
    do
        header_arr+=($header)
    done
    
    {
    echo "<h1>$2</h1>"
    echo "<table>"
    
    for ((index_arr=0; index_arr<$column_total; index_arr++))
    do
        echo "<th>${header_arr[$index_arr]}</th>"
    done
    
    attr_col=1
    for _header_ in ${header_arr[@]}
    do
    
        if [ "$_header_" = "COLOR_BUCKET" ]
        then
            color_attr=$attr_col
    	
        elif [ "$_header_" = "HISTOGRAM" ]
        then
            histogram_attr=$attr_col
		elif [ "$_header_" = "USED_PERCENTAGE" ]
		then
		used_percent_attr=$attr_col
        fi
        attr_col=`expr $attr_col + 1`
    done
    
    for ((cur_row=2; cur_row<=$row_total; cur_row++))
    do
        rows=`sed -n $cur_row\p $1`
        echo "<tr>"
    
        for ((index=1; index<=$column_total; index++))
        do
            element=`echo $rows | awk -v col="$index" -F "," '{print $col}'`
    
            if [ "$index" = "$color_attr" ]
            then
                echo "<td><p style="color:$element";><strong>$element</strong></p></td>"
	    elif [ "$index" = "$histogram_attr" ]
	    then
                echo "<td>"
		
		#Making histogram by inserting  a table in a cell
		echo "<table width="100%">"

		used_width=`echo $rows | awk -v used_per_attr="$used_percent_attr" -F "," '{print $used_per_attr}'`
		col1=$used_width
			col2=`expr 100 - $used_width`

			echo "<col style="width:$col1%">"
			echo "<col style="width:$col2%">"
				
			warning_color=`echo $rows | awk -v color_col="$color_attr" -F "," '{print $color_col}'`
			echo "<tr>"
			echo "<td bgcolor="$warning_color">"
		        echo "$col1"
			echo "</td>"

			echo "<td>"
			echo "</td>"

			echo "</tr>"
		echo "</table>"				
		
		echo "</td>"
	
            else
                echo "<td>$element</td>"
            fi
        done
    
        echo "</tr>"
    
    done
    
    echo "</table>"
    } >> admin_report.html
    unset header_arr
    
}


