#!/bin/bash
case "$1" in
	"good" )
	echo "very good !"
	;;
	"fail" )
	echo "you bad"
	;;
	* )
	echo "exit"
	;;
esac
