#! /usr/bin/bash

# 0 is paper 
# 1 is rock
# 2 is scissors

player_one_score=0
player_two_score=0

for i in {1..10}
do
	player_one=`echo $((RANDOM % 3))`
	player_two=`echo $((RANDOM % 3))`
	echo "$player_one vs $player_two"
	if [ $player_one -eq $player_two ]
	then 
		continue
	elif [ $player_one = 0 ] && [ $player_two = 1 ] 
	then	
		player_one_score=`expr $player_one_score + 1`
	elif [ $player_one = 1 ] && [ $player_two = 2 ]
	then 
		player_one_score=`expr $player_one_score + 1`
	elif [ $player_one = 2 ] && [ $player_two = 0 ]
	then 
		player_one_score=`expr $player_one_score + 1`
	else
		player_two_score=`expr $player_two_score + 1`
	fi
done

echo -e "$player_one_score is player one score\t$player_two_score is player two score"
