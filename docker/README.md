## Docker

### docker build

```
docker build -t image_name -f Dockerfile .
```

### How to optimize and Secure Dockerfile?

- Write multistage Dockerfile for better caching and storage optimization.
- Create statically linked binary so that we can copy this binary to alpine , busybox docker image.
- Make sure to run binary using non-root user

### Static scan of Dockerfile using checkov

```bash
docker run -t -v $(pwd):/output bridgecrew/checkov -f /output/Dockerfile -o json
```

- https://docs.bridgecrew.io/docs/docker-policy-index