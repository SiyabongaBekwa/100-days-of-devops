#!/bin/bash

# Day 8 — Install Ansible
#
# Objective:
# Install Ansible 4.7.0 on the Nautilus jump host
# and verify that the installation is available system-wide.
#
# Security:
# Do not store passwords, private SSH keys, API tokens,
# or other sensitive credentials in this file.

# ------------------------------------------------------------
# 1. Install the required Ansible version
# ------------------------------------------------------------

pip3 install ansible==4.7.0

# ------------------------------------------------------------
# 2. Verify the installed Ansible package
# ------------------------------------------------------------

pip3 show ansible

# Expected important values:
# Name: ansible
# Version: 4.7.0
#
# The package was installed under:
# /usr/local/lib/python3.9/site-packages


# ------------------------------------------------------------
# 3. Verify the Ansible CLI
# ------------------------------------------------------------

ansible --version

# Expected important values:
# ansible [core 2.11.12]
# executable location = /usr/local/bin/ansible
# python version = 3.9.19


# ------------------------------------------------------------
# 4. Locate the Ansible executable
# ------------------------------------------------------------

which ansible

# Expected:
# /usr/local/bin/ansible


# ------------------------------------------------------------
# 5. Verify executable permissions
# ------------------------------------------------------------

ls -l $(which ansible)

# Expected permission structure:
# -rwxr-xr-x
#
# This confirms that the executable can be executed
# by the owner, group and other users.


# ------------------------------------------------------------
# Verification Summary
# ------------------------------------------------------------

# Ansible package:
# 4.7.0
#
# Ansible Core:
# 2.11.12
#
# Python:
# 3.9.19
#
# Executable:
# /usr/local/bin/ansible