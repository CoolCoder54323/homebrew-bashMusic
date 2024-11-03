#!/usr/bin/env bash

codeName=$(uname -s)
case $codeName in
	Darwin)
		OS=mac
		;;
	Linux)
		OS=linux
		;;
	*)
		OS=linux
		;;
esac
for dep in sox ffmpeg; do
	check=$(whereis -q $dep)
	if [ -z "$check" ]; then
		echo "'$dep' is not installed. Would you like to (yes/no)"
		read -n 10 install
		if [ "yes" = $install ]; then
			[ $OS = linux ] && sudo apt-get -y install $dep || [ $OS = mac ] && echo "mac install" && brew install $dep 
		else
			exit 1
		fi

	fi
done

getArg() {
	string=$(echo "$RESPONSE" | sed -n "s/.*\"$1\":[\"]*\([^\",]*\)[\"].*/\1/p")

	if [ -z "$string" ]; then
		string=$(echo "$RESPONSE" | sed -n "s/.*\"$1\":\([0-9][0-9]*\).*/\1/p")
	fi
	
	echo "$string"
}

printBox() {
	local wList=("$@")
	local cCount=0
	for line in {0..20}; do
        	skip=$(for whiteLine in ${wList[@]}; do
                	if [ $line -eq $whiteLine ]; then
                        	echo skip
                	fi
			done)
		
		if [ "skip" = "$skip" ]; then 
			local lineContent=${content[cCount]}
			
			strLen=${#lineContent}
			lower=$(( (99 / 2) - (strLen / 2) ))
			upper=$(( lower + strLen ))
			echo -n "|"
			for((space=0;space<lower;space++)){
				echo -n " "
			}
			echo -n "$lineContent"
			for (( space=upper;space<100;space++ )){
				echo -n " "
			}
			echo "|"
			cCount=$((cCount + 1))
			skip=""
			continue
			
		fi

                echo -n "|"
        	for spaces in {0..99}; do
       	        	echo -n " "
        	done
        	echo "|"

	done
	printf -- "-%c\b" {0..99} && printf -- '-\n'
}
removeBox() {
	str=""
	local rem=0
	for((rem=0;rem<22;rem++)); do
		str="$str\r\x1B[A"
	done
	printf $str
}

printLoadBar() {
	local total=$2
	local curr=$1
	local tick
	echo -n [
	for((tick=0;tick<total;tick++)){
		if [ $tick -lt $curr ]; then
			echo -n "-"
		elif [ $tick -eq $curr ]; then
			echo -n "/"
		else
			echo -n "_"
		fi
	
	}
	echo ]
}

if [ ! $# -eq 1 ]; then 
	echo only takes one arg not $#
	exit 1
fi

formatedQuery=$(echo "$1" | tr -s '[:space:]' '+' | sed 's/+$//')
fullSearch="https://itunes.apple.com/search?term=$formatedQuery&media=music&limit=1"
RESPONSE=$(curl -sA 'Mozilla/5.0' "$fullSearch")

if [ -z "$RESPONSE" ]; then
	echo "Connection failed"
	exit 1
fi

responses=$(getArg resultCount)

if [ "$responses" -eq 0 ]; then
	echo "Sorry no results for that search"
	exit 0
fi

echo "Curled: '$fullSearch'"

name=$(getArg trackName)
artist=$(getArg artistName)
prevLink=$(getArg previewUrl)
title="You should listen to: $name by  $artist! Heres a preview :)"

printf "\n$title\n\n"

curl -so /tmp/preview.m4a "$prevLink"

durr=$(ffmpeg -i /tmp/preview.m4a -f sox -y /tmp/out.sox 2>&1 | sed -nE "s/.*Duration: [0-9]{2}:[0-9]{2}:([0-9]{2})\.[0-9]{2}.*/\1/p")
play -q /tmp/out.sox >/dev/null 2>&1 &

cleanup(){
	echo
	echo Thanks for listening
	rm /tmp/out.sox /tmp/preview.m4a
	exit 0
}

trap cleanup SIGINT
whiteList=(3 4 13 14 17)
content=( "$name" "$artist" "[]" "0/30 sec" "ctrl-c to exit early")

printf -- '-%c\b' {0..99} && printf -- '-\n'
for(( i=0; i<$((durr+1));i++)){
	content[3]="$i/$durr sec"
	content[2]="$(printLoadBar $i $durr)"
	printBox ${whiteList[@]}
	sleep 1
	removeBox
}
printBox ${whiteList[@]}
cleanup



