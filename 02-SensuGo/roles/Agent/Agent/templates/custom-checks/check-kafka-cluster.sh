#!/bin/bash

kafka="/opt/kafka/config"
path="/home/kafka/kafka/bin/zookeeper-shell.sh"

ZK_HOST="localhost"
ZK_PORT=2181

data1=()
count1=0
for broker_id in $(cat   $kafka/zookeeper.properties   | grep -w server | cut -d "=" -f 1 | cut -d "." -f2 ); do

        data1[count1]=$broker_id
        count1=$((count1+1))

done


data2=()
data2=`/opt/kafka/bin/zookeeper-shell.sh localhost:2181 ls /brokers/ids 2>/dev/null | grep "0"  | cut -d "[" -f2 | cut -d "]" -f1 | sed 's/,//g' `

a1=${data1[*]}
a2=${data2[*]}


if [[ $a1 = $a2 ]]
then
       echo "Node are in sync "
       exit 0
else
        echo "Node are not in sync"
        exit 1
fi

