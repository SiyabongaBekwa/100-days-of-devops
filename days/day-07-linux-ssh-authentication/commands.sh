#!/bin/bash

# ============================================================

# Day 7 — Linux SSH Authentication

# ============================================================

#

# Objective:

# Configure passwordless SSH authentication from the

# Nautilus Jump Host to the application servers.

#

# Source:

# thor@jump-host

#

# Target servers:

# tony@stapp01

# steve@stapp02

# banner@stapp03

#

# Security:

# Do NOT store passwords, private SSH keys, tokens,

# cloud credentials, or other secrets in this file.

#

# ============================================================

# ============================================================

# 1. Configure SSH key authentication for App Server 1

# ============================================================

ssh-copy-id tony@stapp01

# ============================================================

# 2. Test passwordless SSH authentication to App Server 1

# ============================================================

ssh tony@stapp01

# Exit the remote server after verification:

exit

# ============================================================

# 3. Configure SSH key authentication for App Server 2

# ============================================================

ssh-copy-id steve@stapp02

# ============================================================

# 4. Test passwordless SSH authentication to App Server 2

# ============================================================

ssh steve@stapp02

# Exit the remote server after verification:

exit

# ============================================================

# 5. Configure SSH key authentication for App Server 3

# ============================================================

ssh-copy-id banner@stapp03

# ============================================================

# 6. Test passwordless SSH authentication to App Server 3

# ============================================================

ssh banner@stapp03

# Exit the remote server after verification:

exit

# ============================================================

# 7. Final verification

# ============================================================

#

# Each connection should authenticate using the configured

# SSH key without requiring the remote user's password.

#

# ============================================================

ssh tony@stapp01

exit

ssh steve@stapp02

exit

ssh banner@stapp03

exit

# ============================================================

# Expected Configuration

# ============================================================

#

# thor@jump-host

# |

# +----> tony@stapp01

# |

# +----> steve@stapp02

# |

# +----> banner@stapp03

#

# All connections should work without a password prompt.

#

# ============================================================

#

# IMPORTANT:

#

# The passwords used during the KodeKloud lab are NOT included

# in this repository.

#

# Private SSH keys must also NEVER be committed to GitHub.

#

# ============================================================
