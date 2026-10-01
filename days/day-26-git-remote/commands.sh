```bash
#!/bin/bash

# Day 26 - Git Remote Configuration, Commit and Push
# KodeKloud 100 Days of DevOps
#
# Repository:
# /usr/src/kodekloudrepos/beta
#
# Objective:
# Add the dev_beta remote, copy index.html into the repository,
# commit it to master, and push master to dev_beta.

# Connect to the Storage Server
ssh natasha@ststor01

# Navigate to the repository
cd /usr/src/kodekloudrepos/beta

# Verify the current branch
sudo git -c safe.directory=/usr/src/kodekloudrepos/beta branch

# Add the new Git remote
sudo git -c safe.directory=/usr/src/kodekloudrepos/beta remote add dev_beta /opt/xfusioncorp_beta.git

# Verify configured remotes
sudo git -c safe.directory=/usr/src/kodekloudrepos/beta remote -v

# Copy index.html into the repository
sudo cp /tmp/index.html /usr/src/kodekloudrepos/beta/

# Verify the copied file
ls -l /usr/src/kodekloudrepos/beta/index.html

# Stage index.html
sudo git -c safe.directory=/usr/src/kodekloudrepos/beta add index.html

# Verify the staged change
sudo git -c safe.directory=/usr/src/kodekloudrepos/beta status

# Commit index.html to master
sudo git -c safe.directory=/usr/src/kodekloudrepos/beta commit -m "Add index.html"

# Push master to the new dev_beta remote
sudo git -c safe.directory=/usr/src/kodekloudrepos/beta push dev_beta master
```
