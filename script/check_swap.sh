#!/bin/bash
Free_Swap=`free -m|awk 'NR==3{print $NF}'`
if [ "$Free_Swap" -le 50000 ];then
	echo "Curcentdd is $Free_Swap"
    echo "swap is no info" |mail -s "swap is stop "  wangzhiqiang@51jiabo.com  >/dev/null 2>&1
else
	echo "SWAP=$Free_Swap"
fi

