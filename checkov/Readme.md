## Checkov

Checkov is tool for statically scanning of Dockerifle, K8 deployment file, terraform and aws cloudformation.

```bash
docker run -t -v $(pwd):/output bridgecrew/checkov -f /output/Dockerfile -o json |  jq '.'
```

- Docker checks : https://docs.bridgecrew.io/docs/docker-policy-index

- Kubernetes checks : https://docs.bridgecrew.io/docs/kubernetes-policy-index