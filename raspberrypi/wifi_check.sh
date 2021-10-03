#!/bin/bash
export log_file="/var/log/wlan0_netplan.log"
if [[ $(ip r l | grep -o wlan0 | uniq) == "wlan0" ]]
then
    echo "$(date +%d-%m-%Y:%T) wifi is working..." >> $log_file
else
    netplan generate
    echo "$(date +%d-%m-%Y:%T) netplan generated." >> $log_file
    screen -A -m -d -S netplan_apply  netplan apply
    echo "$(date +%d-%m-%Y:%T) netplan apply ran." >> $log_file
    echo "$(date +%d-%m-%Y:%T) rebooting"  >> $log_file
    reboot
fi

# */10 * * * * /opt/cron/wifi.sh
