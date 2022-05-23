### Falco
Falco monitors system call to secure your system.

### Install falco

```bash
rpm --import https://falco.org/repo/falcosecurity-3672BA8F.asc
curl -s -o /etc/yum.repos.d/falcosecurity.repo https://falco.org/repo/falcosecurity-rpm.repo

yum -y install kernel-devel-$(uname -r)

yum -y install falco

#load falco driver

falco-driver-loader

lsmod | grep  falco

modprobe falco-probe

#run falco

falco

# adduser will show alert message

```

### Install using helm chart

```bash
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update

#install
helm install falco falcosecurity/falco

#install with falcosidekick
helm upgrade --install falco falcosecurity/falco --set falcosidekick.enabled=true --set falcosidekick.webui.enabled=true

#with elasticsearch
helm upgrade --install falco falcosecurity/falco --set falcosidekick.enabled=true --set falcosidekick.webui.enabled=true  --set falcosidekick.config.elasticsearch.hostport=http://192.168.0.183:30005
```

Note: - Falco needs kernel headers installed on the host as a prerequisite

### falcosidekick - Connect Falco to your ecosystem(logs, alert, report)

- https://github.com/falcosecurity/falcosidekick#outputs
- https://github.com/falcosecurity/falcosidekick#env-vars # can pass as env
- https://github.com/falcosecurity/charts/blob/master/falcosidekick/README.md#configuration # helm chart values
- https://github.com/kubernetes-sigs/wg-policy-prototypes/tree/master/policy-report - kube-bench , kubearmor

### Refrences
- https://falco.org/docs/getting-started/installation/
- https://github.com/falcosecurity/charts/tree/master/falco
- https://github.com/falcosecurity/charts/tree/master/falcosidekick