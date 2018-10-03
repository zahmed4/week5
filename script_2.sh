#!/bin/bash

#write a script that does that same thing as number 1 but using a fie for data.

echo "Enter name of file that has numbers separated by spaces: "
read fileName
cat $fileName | ./script_1.sh

