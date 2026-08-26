#!/bin/bash

# ============================================================

# KodeKloud 100 Days of DevOps

# Day 1 — Linux User Setup with Non-Interactive Shell

# ============================================================

#

# Objective:

# Create a Linux user with a home directory and configure

# /usr/sbin/nologin as the user's shell.

#

# NOTE:

# Replace <username> with the username specified by the lab.

# Replace <server> and <user> with your lab SSH details.

#

# Do NOT store passwords, private keys, tokens, or credentials

# in this file.

# ============================================================

# ============================================================

# 1. Connect to the application server

# ============================================================

ssh <user>@<server>

# ============================================================

# 2. Create the user

# ============================================================

#

# -m creates the user's home directory under /home

# -s specifies the user's login shell

# /usr/sbin/nologin prevents interactive shell access

#

sudo useradd -m -s /usr/sbin/nologin <username>

# ============================================================

# 3. Verify the user configuration

# ============================================================

cat /etc/passwd

# ============================================================

# 4. Verify the specific user

# ============================================================

grep '<username>' /etc/passwd

# ============================================================

# 5. Test interactive access

# ============================================================

#

# Attempting to switch to the account should result in:

#

# This account is currently not available.

#

sudo su <username>

# ============================================================

# Additional verification commands

# ============================================================

# List users configured with a nologin shell

grep nologin /etc/passwd

# Display user and group information

id <username>

# ============================================================

# Troubleshooting

# ============================================================

# Check whether the user already exists

cat /etc/passwd | grep '<username>'

# Verify that the nologin shell exists

ls -l /usr/sbin/nologin

# ============================================================

# Cleanup — only if required

# ============================================================

#

# Remove the user and its home directory:

#

# sudo userdel -r <username>

#

# ============================================================

# End of Day 1

# ============================================================
