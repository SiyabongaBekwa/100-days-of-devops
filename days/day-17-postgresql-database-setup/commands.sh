```bash
#!/bin/bash

# Day 17 — PostgreSQL Database Setup
# KodeKloud 100 Days of DevOps
#
# This file documents the commands used during the Day 17 lab.
# It is intended as a command reference rather than a fully
# automated deployment script.
#
# Security:
# The PostgreSQL password used during the lab is intentionally
# excluded from this file.

# Connect to the Nautilus database server
ssh peter@stdb01

# Check PostgreSQL service status
sudo systemctl status postgresql --no-pager

# Open the PostgreSQL command-line interface
sudo -u postgres psql

# Create the PostgreSQL database user
# Replace <database-password> with the password used during the lab.
CREATE USER kodekloud_gem WITH PASSWORD '<database-password>';

# Create the required database
CREATE DATABASE kodekloud_db7;

# Grant full permissions on the database
GRANT ALL PRIVILEGES ON DATABASE kodekloud_db7 TO kodekloud_gem;

# Verify the database
\l kodekloud_db7

# Verify the PostgreSQL role
\du kodekloud_gem

# Exit PostgreSQL
\q
```
