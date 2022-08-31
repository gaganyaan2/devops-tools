# webserver led on/off python

```bash
#build
docker buildx create --use --name insecure-builder --buildkitd-flags '--allow-insecure-entitlement security.insecure'

DOCKER_BUILDKIT=1 docker buildx build --allow security.insecure --load -t webserver-led -f Dockerfile .

#run
docker run -d -p 8001:80 --privileged webserver-led
```