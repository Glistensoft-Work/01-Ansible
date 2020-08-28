var=$1
#var=$2
#file=./primary
file=/opt/sensu/embedded/bin/primary
old_ip=$(cat $file)

/usr/bin/mongo admin --host=$1 --quiet --eval "var i=0; rs.status().members.forEach( function(myDoc) { if (myDoc.stateStr=='PRIMARY' && i==0) { print(myDoc.name);} })" > $file

#cat primary

IP=$(cat $file)


if [[ $old_ip == $IP ]]; then
  echo "OK: Now primary server is: $IP"
  exit 0
else
  if [[ $old_ip != $IP ]]; then
    echo "WARNING: Secondary MongoDB switch as primary: $IP"
    exit 1
  else
    echo "Critical: Server unreachbale"
    exit 2
  fi
fi

echo "Unknown: Something went wrong"
exit 3 # or higher

