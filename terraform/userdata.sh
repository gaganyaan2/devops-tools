#! /bin/bash
sudo apt update
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<h1>hola Terraform</h1>" > /var/www/html/index.html