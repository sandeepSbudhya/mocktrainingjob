#!/bin/bash

if [ $# -eq 2 ]
then        
    url=$1
    file=""
    script="sendmessages/sendMessageToKafka.sh"
    if [ $2 == "performance" ]
    then
        url="$url/producemessage/performance"
        file="performanceMessage.json"
        echo "type of message: performance"
        echo "url is: $url"
    fi
    if [ $2 == "progress" ]
    then
        url="$url/producemessage/progress"
        file='progressMessage.json'
        echo "type: progress"
        echo "url is: $url"
    fi
    if [ $file == "" ]
    then
        echo "types of messages are progress or performance"
        exit
    fi
    echo "tapis job id: $_tapisJobUUID"
    filecopy=""sendmessages/copy"$file"
    cp "sendmessages/$file" $filecopy
    echo "json message:"
    echo -n "\"$_tapisJobUUID\"" >> $filecopy
    echo "" >> $filecopy
    echo "}" >> $filecopy
    cat $filecopy
    bash $script $url $filecopy
else
    echo "required in order: <kafka_broker_url> <message_type>"
fi