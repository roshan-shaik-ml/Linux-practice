
# This shell script contains the function required for computing check_sys.sh
#
# Author: Shaik Faizan Roshan Ali 
#
# Email: alashercoder@gmail.com

function byte_converter() {
    for mem in $memories
    do
	if [ $mem -le 1024 ]
	then
	    echo "${mem}"
	elif [ $ mem -gt 1024 ] && [ $mem -le 1048576 ]
	then
	    storage=`expr $mem / 1024`
	    echo "${storage} KB"
	elif [ $mem -gt 1048576 ] && [ $mem -le 1073741824 ]
	then
	    storage=`expr $mem / 1048576`
	    echo "${storage} MB"
	else
	    storage=`expr $mem / 1073741824`
	    echo "${storage} GB"
	fi
    done
}

function bucketize() {

    #arranging them in buckets
    used_percent=`df -kh | awk 'NR>1{print $5}'| sed 's/%//g'`
    
    for percent_value in $used_percent
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
}

function sort_color() {
    `cat admin_report.csv | sort -k 3 > admin_report_sorted.csv`
    _file_paths_=`awk -F "," '{print $1}' admin_report_sorted.csv`
    _buckets_=`awk -F "," '{print $2}' admin_report_sorted.csv`
    _used_percents_=`awk -F "," '{print $3}' admin_report_sorted.csv`    
    _space_available_=`awk -F "," '{print $4}' admin_report_sorted.csv`
    
    for filepath in $_file_paths_
    do
        file_path_arr+=($filepath)
    done
    
    for bucket in $_buckets_
    do
        bucket_arr+=($bucket)
    done
    
    for usedpercent in $_used_percents_
    do
        used_percent_arr+=($usedpercent)
    done
    
    for space in $_space_available_
    do
        space_avail_arr+=($space)
    done
}

function backup() {
    current_directory=`pwd`
    cd
    tar czfp /home/Faizan/backup.tar.gz /home/Faizan/
}

function junk_uninstall() {
user_list=`cat /etc/passwd | awk -F ":" '{if($3>=1000){print $1}}' | grep -vi "nobody"`

    # installing the blacklisted package for testing
    sudo apt-get install cowsay 1> /dev/null

    declare -a blacklist_apps
    blacklist_apps+=(cowsay)

    packages=`sudo dpkg-query -l`

    for package in "${blacklist_apps[@]}"
    do  
	check_package=`sudo dpkg-query -l | grep -i "$package" | echo $?` 
        
	# $? check for the exit status of the last pipeline command
        if [ "$check_package" -eq 0 ] 
        then
            sudo dpkg --remove $package > /dev/null
            echo "$package Uninstalled sucessfully." | ts  >> logfile.txt
        elif [ "$check_package" -eq 127 ] 
        then
            echo "No blacklist pacakges are installed !!!" | ts >> logfile.txt
        fi
    done
    `exit`
}

function bucketize_user() {
    for ((index=0; index<$user_count; index++))
    do 
        if [ "${user_bucket[$index]}" -le 1073741824 ]
        then
            user_bucketize+=(green)
        elif [ "${user_bucket[$index]}" -gt 1073741824 ]
        then 
            user_bucketize+=(red) 
        else
            echo "error"
        fi
    done
}

function check_packages() {
    top_five_mem=`dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n | tail -n 5 |     awk '{print $1}'`
    top_five_names=`dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n | tail -n 5 | awk '{print $2}'`

    for package in $top_five_names
    do
	most_occupied+=($package)
    done

    for mem in $top_five_mem
    do
	space_occupied+=($mem)
    done
}

function html_handcode() {
    {
    echo "<html>"
    echo "<head>"
    echo "CSV to HTML"
    echo "<style>"
    echo "table {"
    echo "  font-family: arial, sans-serif;"
    echo "  border-collapse: collapse;"
    echo "  width: 100%;"
    echo "}"
    echo ""
    echo "td, th {"
    echo "  border: 1px solid #dddddd;"
    echo "  text-align: left;"
    echo "  padding: 8px;"
    echo "}"
    echo ""
    echo "tr:nth-child(even) {"
    echo "  background-color: #dddddd;"
    echo "}"
    echo "body {"
    echo "background-color: #FFF5EE;"
    echo "}"
    echo "</style>"
    echo "</head>"
    echo "</body>"
    } > admin_report.html
}

function csv2html() {

    csv_files=`ls -a | grep -i "table"`
   
    for csv_file in $csv_files
    do 
            column_total=`cat $csv_file | awk -F "," 'NR<2{print NF}'`
            row_total=`cat $csv_file | awk '{print $1}' | wc -l`
            
            headers=`head -n 1 $csv_file | tr -s ',' ' '`
        
            for header in $headers
            do
                header_arr+=($header)
            done
            
            {
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
                rows=`sed -n $cur_row\p $csv_file`
                echo "<tr>"
            
                for ((index=1; index<=$column_total; index++))
                do
                    element=`echo $rows | awk -v col="$index" -F "," '{print $col}'`
            
                    if [ "$index" = "$color_attr" ]
                    then
                        echo "<td><p style="color:$element">$element</p></td>"
                    
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
    done
}


