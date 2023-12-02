#!/bin/bash

PARAM=$1

###### mysql ######
MYSQL_NAME="mdb"
MPW="mypwd"

runMysql() {
    echo "mysql"
    docker run --name ${MYSQL_NAME} -e MYSQL_ROOT_PASSWORD=${MPW} -p 33060:3306 -d mysql:latest
}


###### redis ######
REDIS_NAME="rdb"
runRedis(){
    echo "start redis"
    docker run --name ${REDIS_NAME} -p 63790:6379 -d redis redis-server --save 60 1 --loglevel warning
}


case ${PARAM} in
    mysql)
        runMysql
    ;;
    redis)
        runRedis
    ;;
    *)
        echo "please input params with mysql or redis to start container 😄"
    ;;
esac