#!/bin/bash

value=follwer
#value1=leader
variable=`echo stat | nc localhost 2181 | grep Mode | cut -d ":" -f 2`

#echo $variable

if [[ "variable" != "value" ]]
then
     variable2=$((`netstat -ntlp 2>/dev/null  | grep 2888 | awk  {'print $4'}  | cut -d ":" -f2`))

     if [[ $variable2 == "2888" ]]
     then
        echo "2888 port running "
        exit 0
     else
         if [[ "variable" !=  "value" ]]
         then
                 echo "follower "
                 exit 0
         else
                echo "2888 port not running"
                 exit 1
        fi
     fi

else
        exit 2
fi



