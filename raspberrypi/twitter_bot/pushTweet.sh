#!/bin/bash

t_and_h=$(python3 /opt/cron/get_temp_dht11.py)

temprerature=$(echo $t_and_h | awk -F ',' '{print $1}')
humidity=$(echo $t_and_h | awk -F ',' '{print $2}')

unixtime=$(date +%s)

docker run -it tbot python twitterBot.py "Mumbai, temperature=$temprerature C, humidity=$humidity% - by pibot with dht11 sensor at $unixtime #raspberrypi"