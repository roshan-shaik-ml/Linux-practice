#! /usr/bin/bash
echo "Hey you, Do you know you are awesome."
echo "What is your name?"
read name
echo "what is your age?"
read age

if [ $age -le 18 ]
then 
	echo "Hey $name, your age is $age you must be having an eventful day"
elif [ $age -gt 18 ] && [ $age -le 30 ]
then 	
	echo "Hey $name, your age is $age you must be working hard. Make sure to have some fun."
elif [ $age -gt 30 ] && [ $age -le 50 ]
then 
	echo "Hey $name, your age is $age, you must have got a flavour of life by now."
else 
	echo "Hey $name, your age is $age, you must have done a great job. Live a peaceful life."
fi	
