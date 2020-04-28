#!/bin/bash
if [ `netstat -nulpt|grep nginx|wc -l` -gt 0 ];then
	echo "nginx is running"
else
       echo "ngins is stop"
       sleep 10
       nginx
fi
