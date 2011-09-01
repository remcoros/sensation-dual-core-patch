#!/bin/sh
#FILE=$1
#TAG=$2
#TARGET=$3
FILE=src/system/xbin/dcbsp
TAG=debug
TARGET=src/system/xbin/dcbsp.nodebug
FLAG=0 
FOUND=0
T="#ifdef $TAG"
(while read -r line
do 
	if [ "$line" = "$T" ] ;then
		FLAG=1
		FOUND=1
	elif [[ "$line" =~ "log \"" ]] ;then
		# "$(echo $line |awk '{print $1}' )" = "log " ] ;then
		DUMMY=0
	elif [[ "$line" =~ "#debug" ]] ;then
		DUMMY=0
	elif [ "$line" = "#endif" ] && [ $FOUND -eq 1 ] ;then
		FLAG=0
	elif [ $FLAG -ne 1 ] ;then
		echo "$line"
	fi
done <$FILE ) > $TARGET