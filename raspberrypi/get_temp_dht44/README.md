# get_temp_dht11

### Install dependency

```
pip3 install adafruit-circuitpython-dht
apt-get install libgpiod2

#add cron entry

* * * * * /opt/cron/get_temp_dht11.sh

```

### dht11 sensor with docker

```
docker build -t temp -f dht11.Dockerfile .

docker run -it --privileged  temp python get_temp_dht11.py

```

### sending data to pushgateway

```
t_and_h=$(python3 get_temp_dht11.py)

temprerature=$(echo $t_and_h | awk -F ',' '{print $1}')
humidity=$(echo $t_and_h | awk -F ',' '{print $2}')
echo "room_temp $temprerature" | curl --data-binary @- http://192.168.0.183:30008/metrics/job/room_temp/instance/lp-arm-1
echo "room_humidity $humidity" | curl --data-binary @- http://192.168.0.183:30008/metrics/job/room_humidity/instance/lp-arm-1
```


## Refrences:

1. https://www.raspberrypi.org/forums/viewtopic.php?t=235179
2. https://stackoverflow.com/questions/30059784/docker-access-to-raspberry-pi-gpio-pins