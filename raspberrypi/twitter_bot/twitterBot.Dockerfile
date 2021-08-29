FROM python:slim-buster
WORKDIR /twitterbot
RUN apt update && \
    apt install build-essential -y && \
    pip3 install twython
COPY twitterBot.py .