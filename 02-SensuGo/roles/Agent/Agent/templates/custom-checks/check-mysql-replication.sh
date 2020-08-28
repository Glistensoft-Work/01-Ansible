#!/bin/bash
#SQL  MASTER SLAVE  REPLICATION STATUS
#############################################################################################################

MYSQL_USER=root
MYSQL_PASS=CiQ34358!

MYSQL_USERA=cariqdevadmin
MYSQL_PASSA=8hu^#*QR_wEAQ^Y2
MYSQL_HOSTS=10.7.0.4
MYSQL_CONNS="-u ${MYSQL_USERA} -p${MYSQL_PASSA}"

MYSQL_CONN="-u ${MYSQL_USER} -p${MYSQL_PASS}"
mysqladmin ping ${MYSQL_CONN}  > /dev/null

MYSQLD_RUNNING=${?}

service="mysql_replication"
timestamp=$(date +%s)

if [ ${MYSQLD_RUNNING} -eq 0 ]
then

                mysql_localhost=$(mysql $MYSQL_CONN  -e "use cariq;select count(*) from crawler_status_w4iq;")
                mysql_remote=$(mysql  $MYSQL_CONNS -h  $MYSQL_HOSTS  -e "use cariq;select count(*) from crawler_status_w4iq;")


                if [[ ${mysql_localhost} != ${mysql_remote} ]]
                then
                        #echo    "       Master and Slave are not in synchronous         "
                        flag=0
                else
                        #echo    "       Master slave are in Synchrounous        "
                        flag=1
                fi



                if [[ ${flag} != 0 ]]
                then
                         echo "$HOSTNAME.$service $flag $timestamp"

                else
                         echo "$HOSTNAME.$service $flag $timestamp"
                fi
fi

