#!/bin/bash
. /etc/init.d/functions
while true
 do
  #curl -I  192.168.1.60:8008/expo/xcx/AccessToken &>/tmp/60.txt
 if [ `curl -o /dev/null   --connect-timeout 5 -s -w "%{http_code}" 192.168.1.60:8008/expo/xcx/AccessToken | egrep -w  "200|301|302" | wc -l` -gt 0 ];then
   action "AccessToken is ok" /bin/true  &>>/tmp/60.log
   
else
   action "AccessToken is fail" /bin/false  &>>/tmp/60.log
fi
  sleep 5

 done

