import Adafruit_DHT
import time

DHT_SENSOR = Adafruit_DHT.DHT11
DHT_PIN = 4

humidity, temperature = Adafruit_DHT.read(DHT_SENSOR, DHT_PIN)
if humidity is not None and temperature is not None:
    #print("Temp={0:0.1f}C Humidity={1:0.1f}%".format(temperature, humidity))
    print("{0},{1}".format(temperature, humidity))
else:
    print("0,0");
    print("Sensor failure. Check wiring.");