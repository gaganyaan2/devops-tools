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

goss add file /etc/passwd
#once we exit it will copy the goss.yaml from container to current directory

# validate
dgoss run nginx

```
### Refrences
- https://github.com/aelsabbahy/goss
- https://github.com/aelsabbahy/goss/blob/master/docs/manual.md#resource-types