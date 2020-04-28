#!/bin/bash
#read -p "please input two num:"  a  b
a=$1
b=$2
if [ $# -ne 2 ];then
 echo "USAGE:$0 arg1 arg2"
 exit 2
fi
expr $a + 1 &>/dev/null
RETVAL1=$?
expr $b + 1 &>/dev/null
RETVAL2=$?
if [ $RETVAL1 -ne 0 -a $RETVAL2 -ne 0 ];then
   echo  "please input two int again"
   exit 3
fi

if [ $a -gt $b ];then
  echo "$a 大于 $b"
elif [ $a -eq $b ];then
  echo "$a 等于 $b"
elif [ $a -lt $b ];then
  echo "$a 小于 $b"
fi
