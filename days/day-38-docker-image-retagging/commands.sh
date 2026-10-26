#!/bin/bash

# Day 38: Pull and retag a Docker image
# Server: App Server 1 (stapp01)
# User: tony

# Connect to App Server 1 (run this separately from the local machine)
ssh tony@stapp01

# Pull the original BusyBox image
docker pull busybox:musl

# Assign the new tag
docker tag busybox:musl busybox:news

# Verify both tags and their image IDs
docker images busybox

# KodeKloud result reference: 6809e00e83720aedcc71f42c