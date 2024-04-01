#!/bin/bash

if [ $# -eq 2 ]
then 
    url=$1
    type=$2
    script="/app/sendmessages/sendMessageToKafka.sh"
    if [ $type == "performance" ]
    then
        url="$url/producemessage/performance"
        performanceMessage="{\"accuracy\":0.579,\"fmeasure\":0.67,\"precision\":0.55,\"recall\":0.67,\"jobId\":\"$_tapisJobUUID\"}"
        echo "type of message: performance"
        echo "url is: $url"
        echo "message:$performanceMessage"
        bash $script $url $performanceMessage
        exit
    fi
    if [ $type == "progress" ]
    then
        progressMessage="{\"epochsCompleted\":1,\"totalEpochs\":2,\"days\":1,\"hours\":2,\"minutes\":3,\"jobId\":\"$_tapisJobUUID\"}"
        url="$url/producemessage/progress"
        echo "type: progress"
        echo "url is: $url"
        echo "message:$progressMessage"
        bash $script $url $progressMessage
        exit
    fi
    echo "types of messages are progress or performance"
    exit
else
    echo "required in order: <kafka_broker_url> <message_type>"
fi