```bash
#!/bin/bash

# Day 19 — Apache Static Website Deployment
# KodeKloud 100 Days of DevOps
#
# This file documents the commands used during the lab.
# Some commands require interactive authentication.

# Connect to application server 2
ssh steve@stapp02

# Install Apache HTTP Server
sudo dnf install -y httpd

# Configure Apache to listen on port 8089
sudo sed -i 's/^Listen 80$/Listen 8089/' /etc/httpd/conf/httpd.conf

# Verify the configured listening port
grep '^Listen' /etc/httpd/conf/httpd.conf

# Validate Apache configuration
sudo apachectl configtest

# Enable and start Apache
sudo systemctl enable --now httpd

# Check Apache service status
sudo systemctl status httpd --no-pager

# Copy the website backups from the jump host
scp -r thor@jump-host:/home/thor/news /tmp/
scp -r thor@jump-host:/home/thor/cluster /tmp/

# Deploy the websites to Apache's web root
sudo cp -r /tmp/news /var/www/html/
sudo cp -r /tmp/cluster /var/www/html/

# Verify the deployed website files
ls -l /var/www/html/news/
ls -l /var/www/html/cluster/

# Test the news website
curl http://localhost:8089/news/

# Test the cluster website
curl http://localhost:8089/cluster/
```
