#/bin/bash

service_name="kafka_message_lag_count"
Kafka_path="/opt/kafka/bin"

output=`$Kafka_path/kafka-consumer-groups.sh --bootstrap-server 10.7.0.5:9092 --group EdgeAlert  --describe | awk '{print $5}' | grep -v "LAG"| awk '{ SUM += $1} END { print SUM }'`

timestamp=$(date +%s)
echo "$HOSTNAME.$service_name $output $timestamp"


