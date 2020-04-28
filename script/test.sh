#!/bin/bash
for i in `seq 9`
  do
   for ((j=1;j<=i;j++))
     do 
     printf "%-8s" $i*$j=$(($i*$j))
    done
   echo
 done
