#!/bin/bash
 
delta_days=$(python roshan_date.py '1-1-2020' '3-1-2020')
# prints delta in days i.e. 2
echo $delta_days 
