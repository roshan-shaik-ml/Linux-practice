#!/usr/bin/python
 
import datetime
import sys
 
# parse 1st date from command line arg
first_date = datetime.datetime.strptime(sys.argv[1], '%d-%m-%Y')
 
# parse 2nd date from command line arg
second_date = datetime.datetime.strptime(sys.argv[2], '%d-%m-%Y')
 
difference = second_date - first_date
 
print difference.days
