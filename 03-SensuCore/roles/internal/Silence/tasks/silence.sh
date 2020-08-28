#!/bin/bash
filename=/tmp/tmp

while read line; do
  curl -s -i -X  POST \
  -H  'Content-Type: application/json' \
  -d  '{"subscription":"client:'$line'"}' \
  http://127.0.0.1:4567/silenced 

done < $filename 

