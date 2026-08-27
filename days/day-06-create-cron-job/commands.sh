
---

# `commands.sh`

Use this as the complete contents of `commands.sh`:

```bash
#!/bin/bash

# ============================================================
# Day 6 — Create a Cron Job
# ============================================================
#
# Objective:
#
# Install the cron package, start the cron service, and create
# a scheduled cron job for the root user.
#
# The cron job runs every five minutes and writes "hello"
# to /tmp/cron_text.
#
# Security:
#
# Do NOT store passwords, private keys, tokens, or other
# credentials in this file.
#
# Replace the SSH placeholders with the server details
# provided by the KodeKloud lab.
#
# ============================================================


# ============================================================
# 1. Connect to the Application Server
# ============================================================

ssh <user>@<server>


# ============================================================
# 2. Install the Cron Package
# ============================================================

sudo yum install -y cronie


# ============================================================
# 3. Start the Cron Service
# ============================================================

sudo systemctl start crond


# ============================================================
# 4. Verify the Cron Service
# ============================================================

sudo systemctl status crond


# ============================================================
# 5. Check Whether the Cron Service Is Active
# ============================================================

sudo systemctl is-active crond


# Expected output:
#
# active
#
# ============================================================


# ============================================================
# 6. Configure the Root User's Cron Job
# ============================================================
#
# The job runs every five minutes.
#
# Cron schedule:
#
# */5 * * * * echo hello > /tmp/cron_text
#
# ============================================================

sudo crontab -e


# Add the following line:
#
# */5 * * * * echo hello > /tmp/cron_text
#
# ============================================================


# ============================================================
# 7. Verify the Root User's Cron Jobs
# ============================================================

sudo crontab -l


# Expected entry:
#
# */5 * * * * echo hello > /tmp/cron_text
#
# ============================================================


# ============================================================
# 8. Verify the Cron Output
# ============================================================
#
# Wait for the cron job to execute, then check the file.
#
# ============================================================

cat /tmp/cron_text


# Expected output:
#
# hello
#
# ============================================================


# ============================================================
# 9. Verify the Cron Package
# ============================================================

rpm -qa | grep cronie


# ============================================================
# End of Day 6
# ============================================================
#
# The cronie package should be installed.
#
# The crond service should be running.
#
# The root user's crontab should contain:
#
# */5 * * * * echo hello > /tmp/cron_text
#
# ============================================================