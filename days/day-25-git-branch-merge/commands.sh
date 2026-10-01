```bash
#!/bin/bash

# Day 25 - Git Branch, Commit, Merge and Push
# KodeKloud 100 Days of DevOps
#
# Repository:
# /usr/src/kodekloudrepos/demo
#
# Objective:
# Create nautilus from master, add index.html,
# commit it, merge it into master, and push
# both branches to origin.

# Connect to the Storage Server
ssh natasha@ststor01

# Navigate to the repository
cd /usr/src/kodekloudrepos/demo

# Initial branch check
# The repository ownership caused Git's dubious ownership
# protection to trigger.
git branch

# Check the repository branches using a temporary
# safe.directory configuration.
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo branch

# Create the nautilus branch from master
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo checkout -b nautilus master

# Verify the branches
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo branch

# Copy index.html into the repository
# The first attempt without sudo failed because the
# repository was not writable by natasha.
cp /tmp/index.html /usr/src/kodekloudrepos/demo/

# Copy the file with elevated privileges
sudo cp /tmp/index.html /usr/src/kodekloudrepos/demo/

# Verify the copied file
ls -l /usr/src/kodekloudrepos/demo/index.html

# Stage index.html
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo add index.html

# Verify the staged change
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo status

# Commit index.html on the nautilus branch
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo commit -m "Add index.html"

# Switch back to master
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo checkout master

# Verify the current branches
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo branch

# Merge nautilus into master
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo merge nautilus

# Push the nautilus branch to origin
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo push origin nautilus

# Push the updated master branch to origin
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo push origin master
```
