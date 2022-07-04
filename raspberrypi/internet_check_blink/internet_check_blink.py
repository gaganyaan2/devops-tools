import RPi.GPIO as GPIO
from time import sleep 
import sys

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)
GPIO.setup(21, GPIO.OUT, initial=GPIO.LOW)

if sys.argv[1] == "on":
    GPIO.output(21, GPIO.HIGH)
    #print("on")
    exit()
elif sys.argv[1] == "off":
    GPIO.output(21, GPIO.LOW)
    #print("off")
    exit()
elif sys.argv[1] == "blink":
  while True:
    GPIO.output(21, GPIO.HIGH)
    sleep(1)
    GPIO.output(21, GPIO.LOW)
    sleep(1)
    #print("blink")
