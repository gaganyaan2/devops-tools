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


## Refrences:

1. https://www.raspberrypi.org/forums/viewtopic.php?t=235179
2. https://stackoverflow.com/questions/30059784/docker-access-to-raspberry-pi-gpio-pins