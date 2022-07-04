#!/bin/bash
#website="google.com"
#max_timeout="3"
#http_status=$(curl -s -o /dev/null -w "%{http_code}" -m "$max_timeout" "$website")

while(true)
do
    ping 8.8.8.8 -c 1 -W 2 || false

    if [ "$?" != "0" ]
    then
        python3 internet_check_blink.py on
    else
        python3 internet_check_blink.py off
    fi
sleep 3
done
