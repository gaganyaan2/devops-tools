## Spark

### helm install

```
helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator
helm install spark spark-operator/spark-operator
```

#### sparkapp.yml python

```yaml
apiVersion: "sparkoperator.k8s.io/v1beta2"
kind: SparkApplication
metadata:
  name: pyspark-pi
  namespace: spark
spec:
  type: Python
  pythonVersion: "3"
  mode: cluster
  image: "gcr.io/spark-operator/spark-py:v3.1.1"
  imagePullPolicy: Always
  mainApplicationFile: local:///opt/spark/examples/src/main/python/pi.py
  sparkVersion: "3.1.1"
  restartPolicy:
    type: OnFailure
    onFailureRetries: 3
    onFailureRetryInterval: 10
    onSubmissionFailureRetries: 5
    onSubmissionFailureRetryInterval: 20
  driver:
    cores: 1
    coreLimit: "1"
    memory: "200m"
    labels:
      version: 3.1.1
    serviceAccount: spark-spark
  executor:
    cores: 1
    instances: 1
    memory: "200m"
    labels:
      version: 3.1.1
```


#### Refrence:
- https://github.com/GoogleCloudPlatform/spark-on-k8s-operator
