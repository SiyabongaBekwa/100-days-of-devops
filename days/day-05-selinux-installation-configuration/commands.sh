
### `commands.sh`

```bash
#!/bin/bash

# ============================================================
# Day 5 — SELinux Installation and Configuration
# ============================================================
#
# Objective:
#
# Install the required SELinux packages and permanently
# disable SELinux on the designated application server.
#
# Security:
#
# Do NOT store passwords, private keys, tokens, or other
# credentials in this file.
#
# Replace the placeholders below with the values provided
# by the KodeKloud lab.
#
# ============================================================


# ============================================================
# 1. Connect to the Application Server
# ============================================================

ssh <user>@<server>


# ============================================================
# 2. Install SELinux Packages
# ============================================================
#
# Install the required SELinux policy packages.
#
# -y automatically confirms the installation.
#
# ============================================================

sudo yum install -y selinux-policy selinux-policy-targeted


# ============================================================
# 3. Open the SELinux Configuration File
# ============================================================
#
# The persistent SELinux configuration is stored in:
#
# /etc/selinux/config
#
# ============================================================

sudo vi /etc/selinux/config


# ============================================================
# 4. Disable SELinux Permanently
# ============================================================
#
# Set the following configuration:
#
# SELINUX=disabled
#
# This configures SELinux to remain disabled after reboot.
#
# ============================================================


# ============================================================
# 5. Verify the Persistent Configuration
# ============================================================

cat /etc/selinux/config


# ============================================================
# 6. Check the SELinux Configuration Directly
# ============================================================

grep '^SELINUX=' /etc/selinux/config


# Expected output:
#
# SELINUX=disabled
#
# ============================================================


# ============================================================
# 7. Check SELinux Status
# ============================================================

sestatus


# ============================================================
# 8. Check Installed SELinux Packages
# ============================================================

rpm -qa | grep selinux


# ============================================================
# End of Day 5
# ============================================================
#
# The lab requires SELinux to be permanently disabled.
#
# A reboot is not required as part of the challenge.
#
# ============================================================