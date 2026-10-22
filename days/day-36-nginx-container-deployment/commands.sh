#!/bin/bash

# Day 36 - Nginx Container Deployment
# KodeKloud 100 Days of DevOps
# Application Server: stapp01

# Connect to Application Server 1 from the jump host.
ssh tony@stapp01

# Create and start the Nginx container in detached mode.
docker run -d --name nginx_1 nginx:alpine

# Verify that the container is running.
docker ps

# List all containers, including stopped containers, if needed.
docker ps -a

# KodeKloud result reference:
# 6809de5183720aedcc71f429