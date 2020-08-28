#!/bin/bash
#SQL  MASTER SLAVE  REPLICATION STATUS
#############################################################################################################

MYSQL_USER=root
MYSQL_PASS=CiQ34358!

MYSQL_USERA=cariqadmin
MYSQL_PASSA=9lu2*#^BT_wEST^6
MYSQL_HOSTS=10.3.0.13
MYSQL_CONNS="-u ${MYSQL_USERA} -p${MYSQL_PASSA}"

MYSQL_CONN="-u ${MYSQL_USER} -p${MYSQL_PASS}"
mysqladmin ping ${MYSQL_CONN}  > /dev/null

MYSQLD_RUNNING=${?}


flag=0

if [ ${MYSQLD_RUNNING} -eq 0 ]
then
        #echo -e "                Mysql Service is Running !!!"

                #seconds_behind_slave=$(mysql $MYSQL_CONN -e "show slave status\G" | grep Seconds_Behind_Master | awk '{print $2}')
                #if [[ ${seconds_behind_slave} -ge 60 ]]
                #then
                #                echo    "       SLAVE Replication is delay for TIME : $seconds_behind_slave Seconds"
                #                flag=1

                #fi

           mysql_localhost=$(mysql $MYSQL_CONN  -e "use cariq;select count(*) from crawler_status_w4iq;")
                mysql_remote=$(mysql  $MYSQL_CONNS -h  $MYSQL_HOSTS  -e "use cariq;select count(*) from crawler_status_w4iq;")

                if [[ ${mysql_localhost} != ${mysql_remote} ]]
                then
                        echo    "       Master and Slave are not in synchronous         "
                        flag=1
                else
                        echo    "       Master slave are in Synchrounous        "

                fi

                #Last_SQL_Error=$(mysql  $MYSQL_CONN -h $MYSQL_HOST  -e "show slave status\G" | grep Last_SQL_Error: | awk '{print $2}')
                #if [[ ${Last_SQL_Error} != ' ' ]]
                #then
                #                echo    " $Last_SQL_Error       "
                #                flag=1
                #fi

                if [[ ${flag} != 0 ]]
                then
                        exit 1
                else
                        exit 0
                fi


else
        echo   " "
        echo    "       --------------Alert-------------"
        echo -e "       Mysql Service is Not Running !!!"
        echo    "       --------------------------------"
        echo   " "
        exit    2
fi



################################################################################################################



