# argocd

### add git repo

```sh
argocd repo add git@bitbucket.org:project/example1.git \
--insecure-ignore-host-key \
--ssh-private-key-path .ssh/id_rsa \
--name example1 \
--grpc-web
```

### create app

```sh
argocd app create example1 --repo git@bitbucket.org:project/example1.git --path helm-chart-path \
--dest-namespace default --dest-name in-cluster \
--grpc-web \
--values values.yaml \
--helm-set-file param=values.yaml \
--revision main \
--upsert
```

### env
```sh
ARGOCD_SERVER=example.com
ARGOCD_AUTH_TOKEN=$Token
```

### role
Setting > Projects > default > Add Role > Role-name > policy permission > create > generate token