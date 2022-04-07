# haproxy ingress

### install haproxy with helm

```bash
helm install haproxy-ingress haproxy-ingress/haproxy-ingress\
  --create-namespace --namespace ingress-controller\
  --version 0.13.6\
  --set controller.hostNetwork=true
```

#### example-ingress.yaml

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    kubernetes.io/ingress.class: "haproxy"
    haproxy.org/rewrite-target: "/"
  name: prometheus-ingress
spec:
  rules:
  - host: prometheus.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: prometheus-service
            port:
              number: 9090
```

#### Note : ingress should be installed in same namespace where service(eg. prometheus-service) is located.

```bash
curl -vvv --header 'Host: prometheus.example.com' 192.168.0.183:32520
```

Refrences:
- https://haproxy-ingress.github.io/docs/getting-started/