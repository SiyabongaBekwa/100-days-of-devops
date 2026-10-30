#!/bin/bash

# Day 40: Install and Configure Apache Inside a Docker Container
# Server: Application Server 2 (stapp02)
# User: steve
# Container: kkloud

# Connect to Application Server 2 (run separately from the local machine)
ssh steve@stapp02

# Verify the container is running
docker ps

# Enter the kkloud container
docker exec -it kkloud bash

# Update package lists and install Apache2
apt update
apt install apache2 -y

# Configure Apache to listen on port 8082
sed -i 's/^Listen 80$/Listen 8082/' /etc/apache2/ports.conf

# Update the default virtual host
sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8082>/' /etc/apache2/sites-available/000-default.conf

# Test Apache configuration
apache2ctl configtest

# Start Apache and verify its status
service apache2 start
service apache2 status

# Test the HTTP response
curl -I http://127.0.0.1:8082

# Exit the container and verify it remains running
exit
docker ps

# KodeKloud result reference: 6809e27e83720aedcc71f42f