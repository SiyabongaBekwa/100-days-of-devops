#!/bin/bash

# Day 37 - Docker File Transfer and Integrity Verification
# KodeKloud 100 Days of DevOps
# Server: stapp03
# Container: ubuntu_latest

# Connect to App Server 3 from the jump host.
ssh banner@stapp03

# Verify that the container is running.
docker ps

# Verify that the encrypted source file exists on the host.
ls -l /tmp/nautilus.txt.gpg

# Copy the encrypted file into the container.
docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/usr/src/

# Verify the copied file inside the container.
docker exec ubuntu_latest ls -l /usr/src/nautilus.txt.gpg

# Compare source and destination SHA-256 checksums.
sha256sum /tmp/nautilus.txt.gpg
docker exec ubuntu_latest sha256sum /usr/src/nautilus.txt.gpg

# KodeKloud result reference:
# 6809dfb783720aedcc71f42b