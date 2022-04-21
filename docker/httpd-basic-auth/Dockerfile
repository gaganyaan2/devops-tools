FROM httpd
RUN apt update -y
RUN apt install apache2-utils -y
COPY httpd.conf /usr/local/apache2/conf/
COPY htpasswd /usr/local/apache2/