
## `days/day-09-mariadb-service/commands.sh`

```bash
#!/bin/bash

# ============================================================
# Day 9 — MariaDB Service Troubleshooting
# ============================================================
#
# Objective:
# Troubleshoot the MariaDB service by correcting the
# ownership of the MariaDB data directory and verifying
# that the service starts successfully.
#
# Server:
# stdb01
#
# User:
# peter
#
# Database:
# MariaDB 10.5
#
# Security:
# Do not store passwords, database credentials, private keys,
# API tokens, or other sensitive information in this file.
#
# ============================================================


# ------------------------------------------------------------
# 1. Correct MariaDB data directory ownership
# ------------------------------------------------------------

sudo chown mysql:mysql /var/lib/mysql


# ------------------------------------------------------------
# 2. Verify MariaDB data directory ownership
# ------------------------------------------------------------

ls -ld /var/lib/mysql


# Expected ownership:
#
# mysql mysql
#
# The directory must be owned by the mysql user and group.


# ------------------------------------------------------------
# 3. Start MariaDB
# ------------------------------------------------------------

sudo systemctl start mariadb


# ------------------------------------------------------------
# 4. Check MariaDB service status
# ------------------------------------------------------------

sudo systemctl status mariadb --no-pager


# Expected:
#
# Active: active (running)
#
# The service should also report that it is ready
# to accept SQL requests.


# ------------------------------------------------------------
# 5. Verify that MariaDB is active
# ------------------------------------------------------------

sudo systemctl is-active mariadb


# Expected:
#
# active


# ------------------------------------------------------------
# Verification Summary
# ------------------------------------------------------------

# MariaDB data directory:
# /var/lib/mysql
#
# Required ownership:
# mysql:mysql
#
# MariaDB service:
# mariadb.service
#
# Expected service state:
# active (running)
#
# Final verification:
# active
#
# Challenge:
# Day 9 — MariaDB Service Troubleshooting
#
# Status:
# Completed