# Goss - validation test

### Install

```
curl -fsSL https://goss.rocks/install | sh
```

### create goss.yaml file for validation

```bash
goss a file /etc/passwd
goss a file /var/log/audit/
```

it will generate goss.yaml in current directory

```yaml
file:
  /etc/passwd:
    exists: true
    mode: "0644"
    size: 2626
    owner: root
    group: root
    filetype: file
    contains: []
  /var/log/audit:
    exists: true
    mode: "0700"
    size: 4096
    owner: root
    group: root
    filetype: directory
    contains: []
```

### validate 
It will verify all rules from goss.yaml

```bash
goss validate
```

## dgoss for docker validation

```bash
# add test
dgoss edit nginx

goss add process nginx
goss add port 80
goss add http https://google.com
goss add user nginx
#once we exit it will copy the goss.yaml from container to current directory

# validate
dgoss run nginx

[root@home ~]# dgoss run -p 8000:80 nginx
INFO: Starting docker container
INFO: Container ID: bd8d2f3e
INFO: Sleeping for 0.2
INFO: Container health
INFO: Running Tests
User: nginx: exists: matches expectation: [true]
User: nginx: uid: matches expectation: [101]
User: nginx: gid: matches expectation: [101]
User: nginx: home: matches expectation: ["/nonexistent"]
User: nginx: groups: matches expectation: [["nginx"]]
User: nginx: shell: matches expectation: ["/bin/false"]
Process: nginx: running: matches expectation: [true]
Port: tcp:80: listening: matches expectation: [true]
Port: tcp:80: ip: matches expectation: [["0.0.0.0"]]
HTTP: https://google.com: status: matches expectation: [200]


Total Duration: 0.624s
Count: 10, Failed: 0, Skipped: 0
INFO: Deleting container

```
### Refrences
- https://github.com/aelsabbahy/goss
- https://github.com/aelsabbahy/goss/blob/master/docs/manual.md#resource-types