#!/bin/bash

#write a script that takes data from a file with two columns of data separated by a tab.

echo "Enter name of file that has two columns of numbers separated by a tab: "
read fileName
cat $fileName | awk '{ if(($1>10) && ($2<10)){print}}'
exit
