# Security Context in kubernetes

```yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: alpine
  name: alpine
spec:
  replicas: 1
  selector:
    matchLabels:
      app: alpine
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: alpine
    spec:
      securityContext:
        runAsUser: 1000
        runAsGroup: 3000
        # seccompProfile:
        #     type: Localhost
        #     localhostProfile: my-profiles/profile-allow.json
        # seLinuxOptions:
        #     level: "s0:c123,c456"
      containers:
      - command:
        - sleep
        - "600"
        image: alpine
        name: alpine
        securityContext:
          runAsUser: 1000
          runAsGroup: 3000
          allowPrivilegeEscalation: false
          capabilities:
              add: ["NET_ADMIN", "SYS_TIME"]
              drop: ["CHOWN"]

```

#### get capabilities info
```bash
[root@lp-k8control-1 ~]# getcap  /usr/bin/ping
/usr/bin/ping = cap_net_admin,cap_net_raw+p

root@controlplane ~ ➜  getpcaps 2097
Capabilities for `2097': = cap_chown,cap_dac_override,cap_fowner,cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_setpcap,cap_net_bind_service,cap_net_raw,cap_sys_chroot,cap_mknod,cap_audit_write,cap_setfcap+ep

```
