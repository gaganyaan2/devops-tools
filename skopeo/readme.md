# Skopeo

## Copy multiarch image from one registory to another registory

### login to repository

```bash
[home@home ~]$ skopeo login --username $USER docker.io
Password: 
Login Succeeded!
```

### Copy

```bash
skopeo copy -a docker://nginx docker://koolwithk/nginx
```

## Refrences
- https://github.com/containers/skopeo/blob/main/docs/skopeo-copy.1.md
- https://github.com/containers/skopeo/blob/main/docs/skopeo-login.1.md