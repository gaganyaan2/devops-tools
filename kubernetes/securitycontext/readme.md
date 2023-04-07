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

```

```bash
getcaps /usr/bin/ping
```
