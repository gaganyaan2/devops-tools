#!/bin/bash

t_and_h=$(python3 get_temp_dht11.py)

temprerature=$(echo $t_and_h | awk -F ',' '{print $1}')
humidity=$(echo $t_and_h | awk -F ',' '{print $2}')
echo "room_temp $temprerature" | curl --data-binary @- http://192.168.0.183:30008/metrics/job/room_temp/instance/lp-arm-1
echo "room_humidity $humidity" | curl --data-binary @- http://192.168.0.183:30008/metrics/job/room_humidity/instance/lp-arm-1
