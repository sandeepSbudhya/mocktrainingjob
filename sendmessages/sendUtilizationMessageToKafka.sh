#!/bin/bash

url=$1
while :
do
    us=""
    sy=""
    ni=""
    id=""
    wa=""
    hi=""
    si=""
    st=""
    mtotal=""
    mfree=""
    mused=""
    mcache=""
    stotal=""
    sfree=""
    sused=""
    savail=""
    cpuusage="$(top -b -n 1 | grep Cpu)"
    memusage="$(top -b -n 1 | grep Mem)"
    while IFS=',' read -ra ADDR; do
        for i in "${ADDR[@]}"; do
            arr=($i)
            if [ ${arr[0]} == "%Cpu(s):" ]; then
                declare ${arr[2]}="${arr[1]}"
                continue
            fi
            declare ${arr[1]}="${arr[0]}"
        done
    done <<< $cpuusage

    while IFS=',' read -ra ADDR; do
        arr=($"${ADDR[@]}")
        word0=${arr[0]}
        arr0=($word0)
        if [ ${arr0[1]} == "Mem" ]; then
            mtotal=${arr0[3]}

            word1=${arr[1]}
            arr1=($word1)
            mfree=${arr1[0]}

            word2=${arr[2]}
            arr2=($word2)
            mused=${arr2[0]}

            word3=${arr[3]}
            arr3=($word3)
            mcache=${arr3[0]}
            continue
        fi
        stotal=${arr0[2]}

        word1=${arr[1]}
        arr1=($word1)
        sfree=${arr1[0]}

        word2=${arr[2]}
        arr2=($word2)
        sused=${arr2[0]}
        savail=${arr2[2]}
    done <<< $memusage
    message="{\"cpu\":{\"us\":$us,\"sy\":$sy,\"ni\":$ni,\"id\":$id,\"wa\":$wa,\"hi\":$hi,\"si\":$si,\"st\":$st},\"memory\":{\"total\":$mtotal,\"free\":$mfree,\"used\":$mused,\"cache\":$mcache},\"swap\":{\"total\":$stotal,\"free\":$sfree,\"used\":$sused,\"avail\":$savail},\"jobId\":\"someTapisJobID\"}"
    echo "type: utilization"
    echo "url is: $url"
    echo "message:$message"
    curl -X POST -H 'Content-Type: application/json' -d $message $url
    sleep 1
done