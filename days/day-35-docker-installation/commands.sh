#!/bin/bash

# Day 35 - Install Docker CE and Docker Compose
# KodeKloud 100 Days of DevOps
# Server: stapp03
# OS: CentOS Stream 9

# Connect to App Server 3.
ssh banner@stapp03

# Verify the hostname and operating system.
hostname
cat /etc/os-release

# Inspect configured DNF repositories.
sudo dnf repolist

# Add Docker's official CentOS repository.
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker CE and Docker Compose.
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start Docker and enable it at boot.
sudo systemctl enable --now docker

# Verify Docker service status.
sudo systemctl status docker --no-pager

# Verify installed versions.
docker --version
docker compose version

# KodeKloud result reference:
# 68078bca399a2462b6cc6687