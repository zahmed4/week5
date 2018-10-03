#!/bin/bash
#script that asks to enter integers and then counts how many are under 10 and then adds all integers together. 
 
echo "List numbers separated by a space: "
read num
Sum=0
count=0
for i in $num
do
	Sum=$(($i+$Sum))
	if [ $i -lt 10 ]
	then
		count=$(($count+1))
	fi
done
echo "Total numbers less than 10: " $count
echo "Sum of all numbers entered: " $Sum
