# Prometheus 


### Prometheus HTTP SD endpoints(2.28 or above)

```
#start
docker-compose -f prometheus-compose.yml up -d

#stop
docker-compose -f prometheus-compose.yml down

```

### Prometheus push-gateway

https://github.com/koolwithk/pushgateway-k8.git

Refrences:
1. https://prometheus.io/docs/prometheus/latest/http_sd/
2. https://prometheus.io/docs/prometheus/latest/configuration/configuration/#http_sd_config