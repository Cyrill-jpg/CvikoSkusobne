#!/bin/bash

SERVER=$(echo "$1" | cut -d "/" -f -3)
curl -s $1 |
	tr -d "\n" |
	tr "<" "\n" |
	grep ^img |
       	sed 's/.*src="//' |
	sed 's/".*//' |
	grep -E "^https|^/" |
	while read VALUE
	do
		if echo $VALUE | grep https > /dev/null
		then
			curl -s -O $VALUE
		else
			curl -s -O $SERVER$VALUE
		fi
	done
