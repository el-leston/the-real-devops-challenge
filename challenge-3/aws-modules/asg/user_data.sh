#!/bin/bash
# Update package repository
sudo yum update -y
# Install httpd (Apache)
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<html><h1>Welcome to your Apache Web Server!</h1></html>" | sudo tee /var/www/html/index.html
