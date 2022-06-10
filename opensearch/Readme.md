# Opensearch

### Install helm chart with helm

```bash
helm repo add opensearch https://opensearch-project.github.io/helm-charts/
helm repo update

helm install opensearch opensearch/opensearch --set replicas=1
helm install opensearch opensearch/opensearch-dashboards
```


### Refrences
- https://github.com/opensearch-project/helm-charts/tree/main/charts/opensearch
- https://github.com/opensearch-project/helm-charts/tree/main/charts/opensearch-dashboards


