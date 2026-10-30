#!/bin/bash

# Day 43: Deploy an Nginx Container with Port Mapping
# Server: Application Server 1 (stapp01)
# User: tony

# Connect to Application Server 1 (run separately from the local machine)
ssh tony@stapp01

# Pull the required Nginx Docker image
docker pull nginx:alpine-perl

# Create and start the Nginx container
docker run -d --name blog -p 8089:80 nginx:alpine-perl

# Verify that the container is running
docker ps

# Test the Nginx HTTP response
curl -I http://localhost:8089

# KodeKloud result reference: 6809e43183720aedcc71f432