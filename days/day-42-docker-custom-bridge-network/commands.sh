#!/bin/bash

# Day 42: Create a Custom Docker Bridge Network
# Server: Application Server 3 (stapp03)
# User: banner

# Connect to App Server 3 (run separately from the local machine)
ssh banner@stapp03

# Create the custom Docker bridge network
docker network create 
  --driver bridge 
  --subnet 172.168.0.0/24 
  --ip-range 172.168.0.0/24 
  news

# List available Docker networks
docker network ls

# Inspect the custom network configuration
docker network inspect news

# KodeKloud result reference: 6809e3d983720aedcc71f431