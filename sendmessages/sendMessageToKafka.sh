#!/bin/bash

url=$1
message=$2


while :
do
	curl -X POST -H 'Content-Type: application/json' -d $message $url
	sleep 1
done