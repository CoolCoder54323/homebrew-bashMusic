#!/bin/bash/

if [ ! $# -eq 1 ]; then 
	echo only takes one arg not $#
	exit 1
fi

formatedQuery=$(echo "$1" | tr -s '[:space:]' '+' | sed 's/+$//')
echo $formatedQuery
fullSearch="https://openverse.org/search/audio?q=$formatedQuery&license_type=commercial,modification"
curl -s -A 'Mozilla/5.0' $fullSearch> output.txt

echo "Curled: '$fullSearch'"
grep 'href=' < 'output.txt'
