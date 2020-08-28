#!/bin/bash

#IPs or names of replica set members
rMembers=$*;

# Identify master
for host in $rMembers; do
  master=$host
  isMaster=$(mongo --host $host --port 37018 --quiet --eval 'db.isMaster().ismaster')
  if [ "$isMaster" == "true" ]; then
    break
  fi
done

# Check if none of them are master, this is very rare situation when primary is failed and secondary to primary transition is in progress
if [ "$isMaster" != "true" ]; then
  echo "CRITICAL: No master found"
  exit 1
fi

result=`mongo $master --port 37018 --eval 'var date = new Date();
                             var endTimestamp = new Date(date); endTimestamp.setMinutes (date.getMinutes() -10);
                             var endObjectId = new ObjectId(Math.floor(endTimestamp.getTime()/1000).toString(16) + "0000000000000000");
                             var startTimestamp = new Date (endTimestamp); startTimestamp.setMinutes (endTimestamp.getMinutes() - 20);
                             var startObjectId = new ObjectId(Math.floor(startTimestamp.getTime()/1000).toString(16) + "0000000000000000");
                             var hotCount = db.getSiblingDB("current").geobit.count({_id:{$gt: startObjectId, $lte: endObjectId}});
                             var coldCount = db.getSiblingDB("retainer").geobit.count({_id:{$gt: startObjectId, $lte: endObjectId}});
                             print(","+hotCount+"="+coldCount);'`

allCount=`echo $result | cut -d',' -f2`;

hotCount=`echo ${allCount} | cut -d'=' -f1`;

coldCount=`echo ${allCount} | cut -d'=' -f2`;

 if [[ $hotCount == $coldCount ]]; then
    echo "OK: Count is matching"
    exit 0
  else
    echo "WARNING: Count does not match"
    exit 1
 fi

