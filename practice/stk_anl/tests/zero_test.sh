#! /usr/bin/bash

num=01

while [ "$num" -lt 10 ]
do
    num=`expr $num + 1`
    num=`printf "%2d" "$num" | sed 's/ /0/'`
done

echo $num
