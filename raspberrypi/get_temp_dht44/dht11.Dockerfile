FROM python:slim-buster
WORKDIR /temp
RUN apt update && \
    apt install build-essential python-dev -y && \
    pip3 install Adafruit_Python_DHT
COPY temp.py .