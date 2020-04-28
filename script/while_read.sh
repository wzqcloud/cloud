#!/bin/bash
#方法一： 
exec < file
sum=0
while read line
	do
 	  echo
	done
#方法二：
cat file |while read line
		do
		  echo
		done

#方法三：
while read line
	do
	  echo
	done<file
