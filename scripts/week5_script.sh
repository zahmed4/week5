#!/bin/bash

for number in -5 -4 -3 -2 -1 0 1 2 3 4 5 
do
	if [ $number -gt 0 ]
	then
		echo "Your number" $number " is positive!"
	else 
		echo "Your number" $number " is negative or 0!"
	fi
done 
