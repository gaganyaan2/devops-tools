# Cloudcustodian

```
custodian run --cache-period 0 ec2-stop.yml -s output
custodian run --cache-period 0 deregister-ami.yml -s output
custodian run --cache-period 0 aws_snapshot_delete.yml -s output
```

One of the most useful feature in custodian is **schema** which shows how to use the module.

```bash
custodian schema 	    #Shows all resource available
custodian schema aws 	#Shows aws resource available
custodian schema aws.ec2	 #Shows aws ec2 action and filters
custodian schema aws.ec2.actions	 #Shows ec2 actions only
custodian schema aws.ec2.actions.stop	 #Shows stop sample policy and schema
```

## Reference :

1. https://cloudcustodian.io/docs/developer/installing.html
2. https://cloudcustodian.io/docs/aws/gettingstarted.html

