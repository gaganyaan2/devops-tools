# Cloudcustodian

```
custodian run --cache-period 0 ec2-stop.yml -s output
custodian run --cache-period 0 deregister-ami.yml -s output
custodian run --cache-period 0 aws_snapshot_delete.yml -s output
```

## Reference :

1. https://cloudcustodian.io/docs/developer/installing.html
2. https://cloudcustodian.io/docs/aws/gettingstarted.html

