## toleration patch

Operator = Exists , Equal

```bash
kubectl patch deployment nginx-deployment --patch-file toleration_patch.yml
```

```yaml
  tolerations:
  - key: "example-key"
    operator: "Exists"
    effect: "NoSchedule"
```

```yaml
  tolerations:
  - operator: "Exists"
```

```bash
echo '
  tolerations:
  - operator: "Exists"' > toleration_patch.yml

kubectl patch deployment nginx-deployment --patch-file toleration_patch.yml
```