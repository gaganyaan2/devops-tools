### Multi arch Simple haskell scotty webserver

```bash
docker build -t simple-scotty-webserver -f hola.Dockerfile .

docker run -it -p 3000:3000 simple-scotty-webserver

#multi arch
docker buildx build --push --platform linux/arm64/v8,linux/amd64 -t koolwithk/simple-scotty-webserver .
```

### Create statically linked haskell binary 

```
ghc --make -threaded -optl-static -optl-pthread hola.hs -o hola
```

- https://ro-che.info/articles/2015-10-26-static-linking-ghc