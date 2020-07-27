#! /usr/bin/bash
echo "Hello sir!!! Welcome to the shell hotel."

#set now=$(date +"%H"). Commented for testing
echo ""
echo "Please enter the hours only not minutes in 24 hour format"
echo "What hour of time is it?"
read now


#array for the menu.
declare -a breakfast=('Idli' 'Dosa' 'Puri' 'Vada')
declare -a lunch=('Veg-thali' 'Non-veg thali' 'Curd-rice''Veg-Biryani' 'Non-veg-Biryani' 'Mandi')
declare -a dinner=('Veg-thali' 'Non-veg-thali' 'Veg-Biryani' 'Non-veg-Biryani' 'Mandi' 'Mid-night-biryani')
declare -a beverages=('Coke' 'Thumbsup' 'Pepsi' 'Fanta' 'Sprite')

#notepad of the shell  waiter for taking the order.
set order = 0
set cooldrink=0

#If condition to check the time and suggest the item in the menu accordingly
if [ "$now" -ge "5" ] && [ "$now" -lt "12" ]
then 
	echo "What would you like for your breakfast?"
	echo "we have some amazing :"
	for tiffin in ${breakfast[@]}
	do 
		echo $tiffin
	done 
	echo "-------------------------"
        echo "I would like to order a :"
        read order
        echo "-------------------------"
	
	echo "Beverage of choice:"
	for drink1 in ${beverages[@]}
	do
		echo $drink1
	done	

	echo "-------------------------"
        echo "I would like to order a :"
        read cooldrink
        echo "-------------------------"

	echo "Your order is $order and a $cooldrink beverage"
	


elif [ "$now" -ge "12" ] && [ "$now" -lt "17" ]
then 
	echo "What would you like for your lunch?"
	echo "We have some great:"
	for food1 in ${lunch[@]}
	do 
		echo $food1
	done 
	echo "-------------------------"
	echo "I would like to order a :"
	read order
	echo "-------------------------"
	
	echo "Beverage of choice:"
	for drink2 in ${beverages[@]}
        do
		echo $drink2
	done 

	echo "-------------------------"
        echo "I would like to order a :"
        read cooldrink
        echo "-------------------------"

	echo "Your order is $order and a $cooldrink beverage"

elif [ "$now" -ge "17" ] && [ "$now" -lt "2" ]
then 
	echo "What would you like for your Dinner?"
	echo "We are famous for:"
	for food2 in ${dinner[@]}
	do 
		echo $food2
	done 

	echo "-------------------------"
        echo "I would like to order a :"
        read food2
        echo "-------------------------"

	
	echo "Beverage of choice:"
	for drink3 in ${beverages[@]}
           do     
		 echo $drink3
	done 

	echo "-------------------------"
	echo "I would like to order a :"
        read cooldrink
        echo "-------------------------"

	echo "Your order is $order and a $cooldrink beverage"

else 
	echo "Sorry, Shell Hotel is closed now, please come back at 5am."

fi 	
