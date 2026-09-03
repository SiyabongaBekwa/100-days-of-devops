```bash
#!/bin/bash

# Day 10 — Ecommerce Archive
# Objective:
# Archive the ecommerce application directory and
# transfer the archive to the central storage server.

# Install the ZIP utility
sudo yum install zip -y

# Create the archive script
# The actual script is located at:
# /scripts/ecommerce_archive.sh

# Archive the ecommerce application directory
zip -r /archives/xfusioncorp_ecommerce.zip /var/www/html/ecommerce

# Transfer the archive to the storage server
scp /archives/xfusioncorp_ecommerce.zip natasha@ststor01:/archives/

# Verify the remote archive
ssh natasha@ststor01 "ls -lh /archives/xfusioncorp_ecommerce.zip"

# Security:
# Do not store passwords or private SSH keys in scripts or Git repositories.
# Passwordless SSH authentication should use properly secured SSH keys.
```
