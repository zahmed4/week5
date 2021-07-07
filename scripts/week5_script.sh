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

# JB: This looks good! The only thing that's missing is the ability to accept an arbitrary
#     number of command-line arguments.