#!/bin/bash

sleep 5
t_and_h=$(python3 /opt/cron/get_temp_dht11.py)

temprerature=$(echo $t_and_h | awk -F ',' '{print $1}')
humidity=$(echo $t_and_h | awk -F ',' '{print $2}')

unixtime=$(date +%s)

if [[ "$temprerature" == "" ]]
then
/usr/bin/docker run -i --rm tbot python twitterBot.py "Sorry, My sensor broke this time:$unixtime :("
else
/usr/bin/docker run -i --rm tbot python twitterBot.py "Mumbai, temperature=$temprerature C, humidity=$humidity% - by pibot with dht11 sensor at $unixtime #raspberrypi"
fi