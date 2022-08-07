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
### SSL

- Create self singed cert
```bash
openssl req \
    -new \
    -newkey rsa:4096 \
    -days 365 \
    -nodes \
    -x509 \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=example.com" \
    -keyout example.com.key \
    -out example.com.cert
```
- Create k8 certificate using above cert
```bash
kubectl create secret tls example-cert \
  --key="example.com.key" \
  --cert="example.com.cert"
```

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
 tls:
 - secretName: example-cert
   hosts:
   - prometheus.example.com
```

#### Note : ingress should be installed in same namespace where service(eg. prometheus-service) is located.

```bash
curl -vvv --header 'Host: prometheus.example.com' 192.168.0.183:32520
```

### Static IP for haproxy ingress controller in AWS
- Need to have 3 Elastic IP this is genrally depends on how much subnet you have.
- Edit haproxy-ingress service and add 3 `aws-load-balancer-eip-allocations` and `aws-load-balancer-type: nlb`
```yaml
apiVersion: v1
kind: Service
metadata:
  name: haproxy-ingress
  annotations:
    meta.helm.sh/release-name: haproxy-ingress
    meta.helm.sh/release-namespace: ingress-controller
    service.beta.kubernetes.io/aws-load-balancer-eip-allocations: eipalloc-1,eipalloc-2,eipalloc-3
    service.beta.kubernetes.io/aws-load-balancer-subnets: subnet-1,subnet-2,subnet-3
    service.beta.kubernetes.io/aws-load-balancer-type: nlb
```


### Refrences:
- https://haproxy-ingress.github.io/docs/getting-started/
- https://www.haproxy.com/blog/enable-tls-with-lets-encrypt-and-the-haproxy-kubernetes-ingress-controller/
- https://stackoverflow.com/questions/60095864/how-can-i-assign-a-static-ip-to-my-eks-service