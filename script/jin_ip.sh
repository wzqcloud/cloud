#!/bin/bash
file=$1 
while true
do
        awk '{print $1}' $1|grep -v "^$"|sort|uniq -c >/tmp/tmp.log
        exec </tmp/tmp.log
        while read line
        do
                ip=`echo $line|awk '{print $2}'`
                count=`echo $line|awk '{print $1}'`
                if [ $count -gt 99 ] && [ `iptables -L -n|grep "$ip"|wc -l`  -lt 1 ]
                        then
                                iptables -I INPUT -s $ip -j DROP
                                echo "$line is dropped" >>/tmp/droplist_$(date +%F).log
                fi
        done
        sleep 3
done

