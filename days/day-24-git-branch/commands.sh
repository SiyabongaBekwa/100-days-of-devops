```bash
#!/bin/bash

# Day 24 - Git Branch Creation
# KodeKloud 100 Days of DevOps
#
# Repository:
# /usr/src/kodekloudrepos/ecommerce
#
# Objective:
# Create xfusioncorp_ecommerce from master.
#
# Note:
# These commands document the commands used during the lab.
# The challenge itself was executed on the KodeKloud Storage Server.

# Connect to the Storage Server
ssh natasha@ststor01

# Navigate to the repository
cd /usr/src/kodekloudrepos/ecommerce

# Initial branch check
# This produced a "dubious ownership" error because the
# repository is owned by root.
git branch

# Check repository ownership
ls -ld /usr/src/kodekloudrepos/ecommerce

# Check branches using a temporary safe.directory configuration
git -c safe.directory=/usr/src/kodekloudrepos/ecommerce branch

# Attempt to create the required branch from master
# This initially failed because natasha did not have
# permission to write to the repository's .git directory.
git -c safe.directory=/usr/src/kodekloudrepos/ecommerce branch xfusioncorp_ecommerce master

# Create the branch with elevated privileges
sudo git -c safe.directory=/usr/src/kodekloudrepos/ecommerce branch xfusioncorp_ecommerce master

# Verify the branches
sudo git -c safe.directory=/usr/src/kodekloudrepos/ecommerce branch

# Expected result:
# * kodekloud_ecommerce
#   master
#   xfusioncorp_ecommerce
```
