## create-user-rbac-access

```bash
openssl genrsa -out user1.key 2048
openssl req -new -key user1.key -out user1.csr


cat user1.csr | base64 | tr -d "\n"


cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: user1
spec:
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ2h6Q0NBVzhDQVFBd1FqRUxNQWtHQTFVRUJoTUNXRmd4RlRBVEJnTlZCQWNNREVSbFptRjFiSFFnUTJsMAplVEVjTUJvR0ExVUVDZ3dUUkdWbVlYVnNkQ0JEYjIxd1lXNTVJRXgwWkRDQ0FTSXdEUVlKS29aSWh2Y05BUUVCCkJRQURnZ0VQQURDQ0FRb0NnZ0VCQU12NjlZWnJSaHVqbDQybkNRci9ra28yYS9VbGZaRUxFbTVqNVBpWUFsbSsKbTE5S2lad1oreEtyM2lvQWVoRVJQTGtPM2JjNThwc2IxZ1ljY25ha3JsYU0yTWRBZ25YL0N5VDl0TmlubEg0VApmS2x0RlZBeUhjMkxBcVc1bFlLV0lpRnZFNG9xaUNVaXk1TzlHOXZRcDdhQjVkbXYxZi9oWWNVRGVSWklrckhGCkk0V2RtazZtQldXcThyTVkxSTN0MkRYWnVnWUVwVWpUVW9QcmdJZG1qZk1oanN4d2ZJUVhFTUZTN0JHb1lpVUkKYkdIenIvSkJhZnVBYlNxem5RZWo0Uk5CUTJKd0lCRWhxYmRWZHJEVHJGaG1KTzhjaGxPQ1B6ZHl2MlZkb0hNMQpQdWFrdUQvcEFaYjJ2Wi9zRGtvU3J5MTdicmV0R0F3RitUWXJKWnRPbTZrQ0F3RUFBYUFBTUEwR0NTcUdTSWIzCkRRRUJDd1VBQTRJQkFRQ1V5cENIbFEybHNJWi9YYmZzUzhZdFR4aE5oR24xZG14S0h5c0d3ZHJGK1NEQ0Q3azgKWkRpTk40eEtHTDNhN015OHBPUldKNitTU1V0ZXlIdFpXSUQyeFA2emxLbjhhWXR2Sk1EQ1BaMUlISmxmcThmZgpPZDNaeHhjelN1c2k5QlRNNDJScEZpZElEa2VYamwzQTNZNUFNTG00SkpvcHBMNC9mSWdTdHdoNHQxVWVPbEhCClVkbDZoc2V2ZnFnd0kvZ3BKeXVoOWFBQUpVMElJMmpwYzNQaHdObTBTRUpGUkIwMkdxV0NpcVdFWWFuWVBCcEMKY3hIclkrVVpkaE5yd203Z2tTbzFkMW1QUFJ5QXA5c1VzR3hVSWZoT2ZmVGxjLzRTMWhHdkhEWFRjellBSm0xZQowVVMxcHM4dUhUVzNkU3dab1lMbXNmZDJ6dlJraWxQWmY2YmUKLS0tLS1FTkQgQ0VSVElGSUNBVEUgUkVRVUVTVC0tLS0tCg==
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400  # one day
  usages:
  - client auth
EOF

k certificate approve user1


kubectl get csr/user1 -o yaml

kubectl get csr user1 -o jsonpath='{.status.certificate}'| base64 -d > user1.crt


kubectl create role developer --verb=create --verb=get --verb=list --verb=update --verb=delete --resource=pods


kubectl create rolebinding developer-binding-user1 --role=developer --user=user1

kubectl config set-credentials user1 --client-key=user1.key --client-certificate=user1.crt --embed-certs=true

kubectl config set-context user1 --cluster=kubernetes --user=user1


```