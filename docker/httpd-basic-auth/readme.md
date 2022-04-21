# httpd with basic auth

### Build

```
docker build -t httpd-basic-auth -f Dockerfile .
```

### Run

```
docker run -d -p 8080:80 httpd-basic-auth
```

### basic auth

```
htpasswd -c admin-htpasswd admin
#htpasswd -c <file_name> <user_name>
```

Default htpasswd username/password = admin/admin

### modification for httpd basic auth in httpd.conf

```
<Directory "/usr/local/apache2/htdocs">
    AuthType Basic
    AuthName "Restricted Content"
    AuthUserFile /usr/local/apache2/htpasswd
    Require valid-user
</Directory>
```