# Twitter raspberry pi bot

### Twitter raspberry pi bot with docker:

```
#update secret and access key in twitterBot.py

docker build -t tbot -f twitterBot.Dockerfile .

docker run -it tbot python twitterBot.py "Hola Twitter"

```


## Refrences:

1. https://pimylifeup.com/raspberry-pi-twitter-bot/
2. https://developer.twitter.com/en/portal/dashboard
3. https://projects.raspberrypi.org/en/projects/getting-started-with-the-twitter-api