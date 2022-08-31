from flask import Flask
import RPi.GPIO as GPIO
from time import sleep 
import sys

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)
GPIO.setup(21, GPIO.OUT, initial=GPIO.LOW)
GPIO.setup(20, GPIO.OUT, initial=GPIO.LOW)

app = Flask(__name__)
app.config["DEBUG"] = True

@app.route('/', methods=['GET'])
def home():
    return "<center><h1><a href=/on>ON<a/> <a href=/off>OFF<a/></h1><br></center>"

@app.route('/on', methods=['GET'])
def on():
    GPIO.output(21, GPIO.LOW)
    return "<center><h1><a href=/on>ON<a/> <a href=/off>OFF<a/></h1><br>Light is on;</center>"

@app.route('/off', methods=['GET'])
def off():
    GPIO.output(21, GPIO.HIGH)
    return "<center><h1><a href=/on>ON<a/> <a href=/off>OFF<a/></h1><br>Light is off;</center>"


app.run(host='0.0.0.0', port=5000)