# Remote access docker

```bash
   ┌─────────┐               port ┌────────┐
   │         │                    │        │
   │         │               2375 │        │
   │         ├────────────────────┤        │
   │         │           2376(TLS)│        │
   └─────────┘                    └────────┘
      client                      Docker Host

    192.168.0.10                  192.168.0.11

```

### on client
```bash
export DOCKER_HOST="tcp://192.168.0.11:2375"

```

## Docker socket remote access with socat

- On docker host(192.168.0.114):

```
socat TCP-LISTEN:6644,reuseaddr,fork UNIX-CONNECT:/var/run/docker.sock
```

- On docker client:
```
socat UNIX-LISTEN:/var/run/docker.sock,fork,reuseaddr,unlink-early,user=root,group=docker,mode=770 TCP:192.168.0.114:6644
```

- Docker client:
```
root@lp-arm-2:~# docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS           NAMES
18f7aff52a13   docker:dind   "dockerd-entrypoint.…"   32 minutes ago   Up 32 minutes   2375-2376/tcp   nostalgic_jang
```

- https://unix.stackexchange.com/questions/683688/is-it-possible-to-access-a-unix-socket-over-the-network

- https://serverfault.com/questions/127794/forward-local-port-or-socket-file-to-remote-socket-file