# Internet check LED

### Motivation
Internet is working or not? look at LED.

### as systemd service

```bash
echo '[Unit]
Description=internet_check
Documentation=internet_check
Wants=network-online.target
After=network-online.target

[Service]
User=root
Group=root
Type=simple
Restart=on-failure

ExecStart=/opt/internet_check.sh

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/internet_check.service

systemctl daemon-reload
systemctl start internet_check
systemctl enable internet_check


chmod +x /opt/internet_check.sh

```