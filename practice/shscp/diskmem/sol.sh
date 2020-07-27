#! /usr/bin/bash

inp=`df -k | awk 'NR>1{print $5}' | sed 's/%//g'`

i="1"

for i in $inp
	do
		set mem = $i

		if [ $mem -gt 10 ]
    			df - k | awk 'NR>1{print $1}'

		fi
	done
