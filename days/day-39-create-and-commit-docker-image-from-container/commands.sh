#!/bin/bash

# Day 39: Create and Commit Docker Image From Container
# Server: Application Server 1 (stapp01)
# User: tony

# Connect to Application Server 1 (run separately from the local machine)
ssh tony@stapp01

# Verify that the source container is running
docker ps

# Create a Docker image from the existing container
docker commit ubuntu_latest official:datacenter

# Verify the newly created image
docker images

# Inspect the image details
docker image inspect official:datacenter

# KodeKloud result reference: 6809e16283720aedcc71f42e