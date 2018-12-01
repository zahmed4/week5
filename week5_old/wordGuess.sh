#!/bin/bash

echo "Try to guess the word I'm thinking of: "
read word
while [ $word != "tigers" ]
do
	echo -n "Guess again: "
	read word
done
echo -n "CONGRATULATIONS!"

