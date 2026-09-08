```bash
#!/bin/bash

# Day 16 — Nginx Load Balancer Configuration
# KodeKloud 100 Days of DevOps
#
# This file documents the commands used during the Day 16 lab.
# It is intended as a command reference rather than a fully
# automated deployment script.

# ------------------------------------------------------------
# Connect to the Load Balancer server
# ------------------------------------------------------------

ssh loki@stlb01

# ------------------------------------------------------------
# Check the operating system
# ------------------------------------------------------------

cat /etc/os-release

# ------------------------------------------------------------
# Check the installed Nginx version
# ------------------------------------------------------------

nginx -v

# ------------------------------------------------------------
# Nginx Load Balancer
# ------------------------------------------------------------
#
# The task required Nginx on stlb01 to load-balance HTTP
# traffic across:
#
#   stapp01
#   stapp02
#   stapp03
#
# The required configuration file was:
#
#   /etc/nginx/nginx.conf
#
# The existing Apache ports on the App Servers were not
# supposed to be changed.
#
# ------------------------------------------------------------
# Final verification
# ------------------------------------------------------------

curl http://stlb01:80
```
