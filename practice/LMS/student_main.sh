#! /usr/bin/bash

source welcome.sh
source functions.sh

# processing user request by calling functions

if [ $request="1" ]
then
	check_available

elif [ $request="2" ]
then 
	check_in
elif [ $request="3" ]
then 
	check_available
else 
	echo "Request unknown"
fi

