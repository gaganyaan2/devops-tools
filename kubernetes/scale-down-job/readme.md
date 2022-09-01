# Scale down to zero

- simply create cronjob to scale down deployment(not limited to deployment)
- can also use labels to scale down
- use any kubectl command

## Verfiy rbac permission

```bash
kubectl auth can-i get namespace --as=system:serviceaccount:$namespace:scale-sa

kubectl auth can-i list deploy --as=system:serviceaccount:$namespace:scale-sa
kubectl auth can-i patch deploy --as=system:serviceaccount:$namespace:scale-sa
```