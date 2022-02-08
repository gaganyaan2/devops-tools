### Simple rust webserver

```bash
docker build -t simple-rust-webserver -f Dockerfile .

docker run -it -p 7878:7878 simple-rust-webserver
```