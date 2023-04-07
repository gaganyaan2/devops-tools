## Network policy in kubernetes

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-pod
  labels:
    role: api-pod
spec:
  selector:
    matchLabels:
      app: api-pod
  replicas: 1
  template:
    metadata:
      labels:
        app: api-pod
    spec:
      containers:
      - name: api-pod
        image: nginx
EOF
```


```yaml
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: db-pod
  labels:
    role: db-pod
spec:
  selector:
    matchLabels:
      app: db-pod
  replicas: 1
  template:
    metadata:
      labels:
        app: db-pod
    spec:
      containers:
      - name: db-pod
        image: mysql
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: "testing123"
EOF
```

```yaml
cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: db-network-policy
spec:
  podSelector:
    matchLabels:
      app: db-pod       # should match with spec.selector.matchLabels
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: api-pod
      ports:
        - protocol: TCP
          port: 3306
EOF
```

