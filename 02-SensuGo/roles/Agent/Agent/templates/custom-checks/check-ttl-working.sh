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


result=`mongo $master --port 37018 --eval 'var startTime = db.getSiblingDB("current").geobit.find().limit(1)[0].serverTimestamp;
                             var date = new Date();
                             date1 = new Date ( date ); date1.setDate (date.getDate() - 2);
                             date2 = new Date ( date1 );date2.setMinutes ( date1.getMinutes() - 5);
                             print(","+(startTime>=date2));'`

alert=`echo $result | cut -d',' -f2`;

if $alert ; then
   echo "OK: TTL is working"
else
  echo "WARNING: TTL is not working"
fi

