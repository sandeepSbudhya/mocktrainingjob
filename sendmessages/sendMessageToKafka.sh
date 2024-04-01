#!/bin/bash

url=$1
file=$2

for i in $(seq 1 10);
do
	curl -X POST -H 'Content-Type: application/json' -d @$file $url
	sleep 2
done