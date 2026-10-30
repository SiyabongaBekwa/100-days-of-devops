#!/bin/bash

# Day 41: Create a Dockerfile to Build a Custom Apache Image
# Server: Application Server 2 (stapp02)
# User: steve
# Dockerfile: /opt/docker/Dockerfile

# Connect to Application Server 2 (run separately from the local machine)
ssh steve@stapp02

# Create the Docker directory
sudo mkdir -p /opt/docker

# Create and edit the Dockerfile
sudo vi /opt/docker/Dockerfile

# Verify the Dockerfile contents
sudo cat /opt/docker/Dockerfile

# KodeKloud result reference: 6809e33583720aedcc71f430