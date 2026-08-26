#!/bin/bash

# ============================================================
# Day 3: Secure Root SSH Access
# ============================================================
#
# Objective:
#
# Disable direct SSH login for the root user on the
# designated Nautilus application servers.
#
# NOTE:
#
# Replace <server> and <user> with the SSH details provided
# by the KodeKloud lab.
#
# Do NOT store passwords, private keys, tokens, or other
# credentials in this file.
#
# ============================================================


# ============================================================
# 1. Connect to the application server
# ============================================================

ssh <user>@<server>


# ============================================================
# 2. Check the current SSH configuration
# ============================================================

sudo grep -E '^#?PermitRootLogin' /etc/ssh/sshd_config


# ============================================================
# 3. Edit the SSH daemon configuration
# ============================================================

sudo vi /etc/ssh/sshd_config

#
# Find the PermitRootLogin setting and configure it as:
#
# PermitRootLogin no
#
# Save and exit vi:
#
# Esc
# :wq
# Enter
#


# ============================================================
# 4. Verify the SSH configuration
# ============================================================

sudo grep '^PermitRootLogin' /etc/ssh/sshd_config


# Expected result:
#
# PermitRootLogin no
#


# ============================================================
# 5. Validate the SSH daemon configuration
# ============================================================

sudo sshd -t


# No output indicates that the SSH configuration
# passed the syntax check.


# ============================================================
# 6. Restart the SSH service
# ============================================================

sudo systemctl restart sshd


# ============================================================
# 7. Verify the SSH service
# ============================================================

sudo systemctl status sshd --no-pager


# The SSH service should show:
#
# Active: active (running)
#


# ============================================================
# 8. Verify the effective SSH configuration
# ============================================================

sudo sshd -T | grep permitrootlogin


# Expected result:
#
# permitrootlogin no
#


# ============================================================
# Troubleshooting
# ============================================================

# Check the SSH configuration for syntax errors:

sudo sshd -t


# Check the SSH service:

sudo systemctl status sshd --no-pager


# Check the configured root-login policy:

sudo grep -E '^#?PermitRootLogin' /etc/ssh/sshd_config


# Check the effective SSH configuration:

sudo sshd -T | grep permitrootlogin


# ============================================================
# Expected Final State
# ============================================================
#
# PermitRootLogin no
# SSH configuration passes validation
# SSH service is active and running
# Direct root SSH login is disabled
#
# ============================================================