#!/bin/bash
. /etc/init.d/functions
check_count=0
url=(
http://www.baidu.com
http://www.wzqcloud.cn
http://www.github.com
)

wait(){
	echo -n '3秒后执行检查url操作.........'
	for((i=0;i<3;i++))
		do
	 		echo -n ".";sleep 1
		done
	echo
}
check_url(){

	for((i=0;i<`echo ${#url[*]}`;i++))
		do
    			a=${url[$i]}
   			b=`curl -o /dev/null --connect-timeout 5 -s -w "%{http_code}" $a|egrep -w "200|301|302"|wc -l`
   			if [ $b -ne 1 ];then
				action "$a is error" /bin/false
    			else
        			action "$a is ok"  /bin/true
    			fi

		done
          ((check_count++))
}

main(){
   
     while [ $check_count -lt 3 ]
     	do
    		check_url
  		 # echo $check_count
    		sleep 5   
  	done
}
main

