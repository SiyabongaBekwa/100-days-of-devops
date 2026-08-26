#!/bin/bash

# ============================================================
# Day 2 — Temporary User Setup with Expiry
# ============================================================
#
# Objective:
# Create a temporary Linux user account and configure
# an account expiration date.
#
# NOTE:
# Replace <user> and <server> with the SSH details
# provided by the KodeKloud lab.
#
# Do NOT store passwords, private keys, tokens, or
# other credentials in this file.
# ============================================================


# ============================================================
# 1. Connect to the application server
# ============================================================

ssh <user>@<server>


# ============================================================
# 2. Create the temporary user
# ============================================================

# Create the user 'kirsty' with an account expiration date
# of 28 January 2027.

sudo useradd -e 2027-01-28 kirsty


# ============================================================
# 3. Verify the user account
# ============================================================

# Display the user's UID, GID and group membership.

id kirsty


# ============================================================
# 4. Display the user account entry
# ============================================================

# Check the user's entry in /etc/passwd.

getent passwd kirsty


# ============================================================
# 5. Verify the account expiration
# ============================================================

# Display account aging and expiration information.

sudo chage -l kirsty


# ============================================================
# 6. Additional verification
# ============================================================

# Check the account expiration date directly.

sudo chage -l kirsty | grep "Account expires"


# ============================================================
# Troubleshooting
# ============================================================

# Check whether the user already exists.

getent passwd kirsty


# Display the account status.

sudo passwd -S kirsty


# ============================================================
# Cleanup — only if required
# ============================================================

# Remove the user and its home directory.

# sudo userdel -r kirsty