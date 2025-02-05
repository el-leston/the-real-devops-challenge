#!/bin/bash
# Update package repository
sudo yum update -y
# Install httpd (Apache)
sudo yum install -y httpd
# Install required packages
sudo yum install -y httpd git
sudo systemctl start httpd
sudo systemctl enable httpd

# Clone the Git repository (replace with your repo URL)
sudo git clone https://github.com/eleston-campus/eleston-campus.github.io.git /var/www/html

# Set proper permissions
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html

# Restart Apache to serve new content
sudo systemctl restart httpd


