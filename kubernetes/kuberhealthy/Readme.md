# Kuberhealthy

### install
```bash
helm install kuberhealthy kuberhealthy/kuberhealthy
```

### check cluster status

```bash
kubectl get khchecks

kubectl get svc

curl http://kuberhealthy

```

### Creating Your Own khcheck
- https://github.com/kuberhealthy/kuberhealthy/blob/master/docs/CHECK_CREATION.md

```yaml
apiVersion: comcast.github.io/v1
kind: KuberhealthyCheck
metadata:
  name: kh-test-check 
spec:
  runInterval: 30s # The interval that Kuberhealthy will run your check on 
  timeout: 2m # After this much time, Kuberhealthy will kill your check and consider it "failed"
  podSpec: # The exact pod spec that will run.  All normal pod spec is valid here.
    containers:
    - env: # Environment variables are optional but a recommended way to configure check behavior
        - name: MY_OPTION_ENV_VAR
          value: "option_setting_here"
      image: quay.io/comcast/test-check:latest # The image of the check you just pushed
      imagePullPolicy: Always # During check development, it helps to set this to 'Always' to prevent on-node image caching.
      name: main
```

```
KH_REPORTING_URL: The Kuberhealthy URL to send POST requests to for check statuses.
KH_CHECK_RUN_DEADLINE: The Kuberhealthy deadline for checks as calculated by the check timeout given in Unix.
KH_RUN_UUID: The UUID of the check run.  This must be sent back as the header 'kh-run-uuid' when status is reported to KH_REPORTING_URL.  The Go checkClient package does this automatically.
KH_POD_NAMESPACE: The namespace of the checker pod.
```

## Refrences:
- https://kubernetes.io/blog/2020/05/29/k8s-kpis-with-kuberhealthy/
- https://github.com/kuberhealthy/kuberhealthy/blob/master/docs/CHECK_CREATION.md
- https://github.com/kuberhealthy/kuberhealthy/tree/master/deploy/helm/kuberhealthy