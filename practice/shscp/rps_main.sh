#! /usr/bin/bash

#It is a classic multiplayer (1-2) player Rock Paper Scissors game.
# 0 is rock
# 1 is paper
# 2 is scissors

player_one_score=0
player_two_score=0

echo "+++++++++++++++ Welcome to Rock Paper Scissors +++++++++++++++++"
echo "Please enter number of player:"
read no_of_players

if [ $no_of_players = "1" ]
then 
	echo "Please enter player your name"
	read player_two_name
	for i in {1..5}
	do
        	player_one=`echo $((RANDOM % 3))`
        	
                echo "================================================================"
                echo "Player two please enter the number of your option:"
                echo "* 0 is rock * 1 is paper * 2 is scissors *"
                read -s player_two
                echo "================================================================"

        	if [ $player_one -eq $player_two ]
        	then
			echo "Dude you are thinking like computer or maybe it is thinking like you!!!"
        	elif [ $player_one = 1 ] && [ $player_two = 0 ]
        	then
                	player_one_score=`expr $player_one_score + 1`
        	elif [ $player_one = 2 ] && [ $player_two = 1 ]
        	then
                	player_one_score=`expr $player_one_score + 1`
        	elif [ $player_one = 0 ] && [ $player_two = 2 ]
        	then
                	player_one_score=`expr $player_one_score + 1`
       		else
                	player_two_score=`expr $player_two_score + 1`
       		fi
		
		echo "****************************************************************"
                echo "                                                                                                "
                echo -e "Computer got $player_one_score points\t$player_two_name got $player_two_score points"
                echo "                                                                                                 "
                echo "****************************************************************"
	done

elif [ $no_of_player="2" ] 
then
	echo "Please enter player one name"
	read player_one_name
	echo "Please enter player two name"
	read player_two_name

	for i in {1..5}
	do
		echo "================================================================"
		echo "Player one please enter the number of your option:"
		echo "* 0 is rock * 1 is paper * 2 is scissors *"
		read -s player_one
		echo "================================================================"
		echo "Player two please enter the number of your option:"
		echo "* 0 is rock * 1 is paper * 2 is scissors *"
		read -s player_two
		echo "================================================================"


		if [ $player_one -eq $player_two ]
        	then
			echo "Please try again, Your competitor thinks like you :D"
              		continue
      		elif [ $player_one = 1 ] && [ $player_two = 0 ]
       		then
                	player_one_score=`expr $player_one_score + 1`
        	elif [ $player_one = 2 ] && [ $player_two = 1 ]
        	then
                	player_one_score=`expr $player_one_score + 1`
        	elif [ $player_one = 0 ] && [ $player_two = 2 ]
        	then
                	player_one_score=`expr $player_one_score + 1`
       		else
                	player_two_score=`expr $player_two_score + 1`
       		 fi
	
		echo "****************************************************************"	
		echo "                                                                                                "
		echo -e "$player_one_name got $player_one_score points\t$player_two_name got $player_two_score points"
		echo "										                       "
		echo "****************************************************************"

	done
else
	echo "Invallid Input"
fi
