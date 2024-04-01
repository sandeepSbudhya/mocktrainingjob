#!/bin/bash

url=$1
message=$2


for i in $(seq 1 100);
do
	curl -X POST -H 'Content-Type: application/json' -d $message $url
	sleep 1
done