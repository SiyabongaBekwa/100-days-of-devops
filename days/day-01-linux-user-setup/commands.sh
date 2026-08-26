#!/bin/bash

# ============================================================

# KodeKloud 100 Days of DevOps

# Day 1 — Linux User Setup with Non-Interactive Shell

# ============================================================

#

# Purpose:

# Document the Linux commands used to create/configure a

# user account with a non-interactive shell.

#

# Security:

# Do NOT store passwords, private keys, tokens, or credentials

# in this file.

#

# Replace <username> with the username specified by the lab.

# ============================================================

# ============================================================

# 1. Create the Linux user

# ============================================================

sudo useradd <username>

# ============================================================

# 2. Configure a non-interactive shell

# ============================================================

sudo usermod --shell /sbin/nologin <username>

# ============================================================

# 3. Verify the user's account configuration

# ============================================================

getent passwd <username>

# ============================================================

# 4. Display the username and configured shell

# ============================================================

getent passwd <username> | cut -d: -f1,7

# ============================================================

# Expected result

# ============================================================

#

# The output should show the configured username together

# with a non-interactive shell, for example:

#

# <username>:/sbin/nologin

#

# ============================================================

# End of Day 1

# ============================================================
