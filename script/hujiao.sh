#!/bin/bash
while true
do
curl   http://192.168.1.60:8094/script/getProjectUrl >/tmp/bb.txt
cat /tmp/bb.txt |awk -F "," '{for(i=1;i<=NF;i++) {print $i;}}' >/tmp/dd.txt
cat /tmp/dd.txt | while read line
    do
     curl -s -o /dev/null $line
     echo "$line  Processing has been requested `date +%F" "%H:%M:%S`" >>/tmp/geturl.txt
    done
   sleep 30
done
