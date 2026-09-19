```bash
#!/bin/bash

# Day 20 - Nginx + PHP-FPM
# KodeKloud 100 Days of DevOps
# Server: stapp01
# User: tony

# Connect to the application server
ssh tony@stapp01

# Install Nginx
sudo dnf install -y nginx

# Configure Nginx to listen on port 8091
sudo sed -i 's/listen       80;/listen       8091;/' /etc/nginx/nginx.conf
sudo sed -i 's/listen       \[::\]:80;/listen       [::]:8091;/' /etc/nginx/nginx.conf

# Verify Nginx listeners
grep -n "listen" /etc/nginx/nginx.conf

# Test Nginx configuration
sudo nginx -t

# Check available PHP modules
sudo dnf module list php

# Enable PHP 8.1
sudo dnf module enable -y php:8.1

# Install PHP and PHP-FPM
sudo dnf install -y php php-fpm

# Create PHP-FPM socket directory
sudo mkdir -p /var/run/php-fpm

# Inspect PHP-FPM configuration
sudo grep -nE '^(listen|user|group|;listen.owner|;listen.group|;listen.mode)' /etc/php-fpm.d/www.conf

# Configure PHP-FPM Unix socket
sudo sed -i 's|^listen = .*|listen = /var/run/php-fpm/default.sock|' /etc/php-fpm.d/www.conf

# Configure PHP-FPM socket ownership and permissions
sudo sed -i \
  -e 's|^;listen.owner =.*|listen.owner = nginx|' \
  -e 's|^;listen.group =.*|listen.group = nginx|' \
  -e 's|^;listen.mode =.*|listen.mode = 0660|' \
  /etc/php-fpm.d/www.conf

# Verify PHP-FPM socket configuration
sudo grep -nE '^(listen|listen.owner|listen.group|listen.mode)' /etc/php-fpm.d/www.conf

# Inspect the Nginx server configuration
sudo sed -n '30,75p' /etc/nginx/nginx.conf

# Change the Nginx document root
sudo sed -i 's|root         /usr/share/nginx/html;|root         /var/www/html;|' /etc/nginx/nginx.conf

# Verify the document root
sudo grep -n 'root' /etc/nginx/nginx.conf

# PHP location configuration used in nginx.conf
#
# location ~ \.php$ {
#     include fastcgi_params;
#     fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
#     fastcgi_pass unix:/var/run/php-fpm/default.sock;
# }

# Inspect the Nginx configuration with line numbers
sudo nl -ba /etc/nginx/nginx.conf | sed -n '35,90p'

# Remove conflicting PHP-FPM configuration using the old socket
sudo rm /etc/nginx/conf.d/php-fpm.conf

# Remove the default PHP configuration using the old php-fpm upstream
sudo rm /etc/nginx/default.d/php.conf

# Test Nginx configuration
sudo nginx -t

# Enable and start PHP-FPM
sudo systemctl enable --now php-fpm
sudo systemctl status php-fpm --no-pager

# Enable and start Nginx
sudo systemctl enable --now nginx
sudo systemctl status nginx --no-pager

# Verify PHP-FPM socket
sudo ls -l /var/run/php-fpm/default.sock

# Reload Nginx after configuration changes
sudo systemctl reload nginx

# Test PHP application locally
curl http://localhost:8091/index.php

# Exit the application server
exit

# Final verification from the jump host
curl http://stapp01:8091/index.php
```
