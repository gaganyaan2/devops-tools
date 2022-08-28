### Multi arch Simple httpd webserver

```bash
#multi arch
docker buildx build --push --platform linux/arm64/v8,linux/amd64 -t koolwithk/httpd-custom .
```

