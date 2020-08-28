memory=$(head -1000 /var/log/messages | egrep "Out of memory|oom" -ic)
#head -5000 /var/log/messages | grep 'Out of memory'

#echo $memory

#message=$(echo -n "$memory" | grep -c '^')

if [ $memory -lt 1 ]; then
  echo "OK: Memory is Ok:"
  exit 0
else

    memory=$(head -1000 /var/log/messages |egrep -i "Out of memory|oom" )
    echo "Critical: Server is out of memory:"
    echo "$memory"
    exit 1
fi

echo "Unknown: Something went wrong"
exit 2 # or higher


