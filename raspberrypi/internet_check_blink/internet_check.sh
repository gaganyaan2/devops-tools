#!/bin/bash
#website="google.com"
#max_timeout="3"
#http_status=$(curl -s -o /dev/null -w "%{http_code}" -m "$max_timeout" "$website")

while(true)
do
    ping 8.8.8.8 -c 1 -W 1 || false
    check1=$(echo $?)
    ping 8.8.8.8 -c 1 -W 1 || false
    check2=$(echo $?)

    if [ "$check1" = "1" ] || [ "$check2" = "1" ]
    then
        python3 /opt/internet_check_blink.py on
    else
        python3 /opt/internet_check_blink.py off
    fi
sleep 2
done