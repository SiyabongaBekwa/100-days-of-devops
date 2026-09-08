#!/bin/bash

# Connect to App Server 1

ssh tony@stapp01

# Check operating system

cat /etc/os-release

# Install Nginx

sudo dnf install -y nginx
