# kubernetes auditing


### get pod, cm, secrets logs at Metadata level

```yaml
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
  - level: Metadata
    resources:
    - group: ""
      resources: ["pods"]
    namespaces: ["cs16"]
  - level: Metadata
    resources:
    - group: ""
      resources: ["configmaps","secrets"]
    namespaces: ["cs16"]
```

#### /etc/kubernetes/manifests/kube-apiserver.yaml
```
    - --audit-policy-file=/etc/kubernetes/audit-policy.yaml
    - --audit-log-path=/var/log/kubernetes/audit/audit.log

```

- https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/
