#!/bin/bash
path=/server/script
[ ! -d "$path" ] && mkdir -p $path

menu(){
cat <<END
	  1.[install lamp]
	  2.[内核优化]
	  3.[exit]
END

read -p "please input the num you want: "  num

expr $num + 1 &>/dev/null
[ $? -ne 0 ] && {
	echo "the num you input must be {1|2|3}"
	exit 1
}
[ $num -eq 1 ] && {
	echo  "start install lamp"
	sleep 3
	[ -x "$path/lamp.sh" ] || {
	echo "$path/lamp.sh does not exit or can not be exec."
	exit 1
	}
	$path/lamp.sh
	exit $?

}

[ $num -eq 2 ] && {
	echo  "内核优化................................"
	sleep 3
	[ -x "$path/socket.sh" ] || {
	echo "$path/socket.sh does not exit or can not be exec."
	exit 1
	}
	$path/socket.sh
	exit $?

}
[ $num -eq 3 ] && {
	echo "goodbye"
	exit 3
}

[[ ! "$num" =~ [1-3] ]] && {
	echo "Input error"

}

}
menu
