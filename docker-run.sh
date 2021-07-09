#!/bin/bash

ID_DB=`sudo docker ps | grep mongo | awk '{print $1}'`
if test -z "$ID_DB" 
then
  echo "Not found docker id of mongo database. Please run docker for mongo database first using docker-mongo.sh";
  exit 0;
else
  echo "ID_DB: $ID_DB"
fi

sudo docker run --rm -i -t \
  --privileged \
  -p 5555:5555 \
  -p 5672:5672 \
  -v $PWD:/autoperf \
  --link $ID_DB:$ID_DB \
  danguria/gem5-autoperf
