```bash
#!/bin/bash

# Day 27 - Git Revert
# KodeKloud 100 Days of DevOps
#
# Repository:
# /usr/src/kodekloudrepos/news
#
# Objective:
# Revert the latest HEAD commit and create a new
# revert commit using the required message "revert news".

# Connect to the Storage Server
ssh natasha@ststor01

# Navigate to the repository
cd /usr/src/kodekloudrepos/news

# Check the latest two commits
sudo git -c safe.directory=/usr/src/kodekloudrepos/news log --oneline -2

# Revert the latest commit
sudo git -c safe.directory=/usr/src/kodekloudrepos/news revert --no-edit 647f86b

# Amend the automatically generated revert commit message
sudo git -c safe.directory=/usr/src/kodekloudrepos/news commit --amend -m "revert news"

# Verify the final commit history
sudo git -c safe.directory=/usr/src/kodekloudrepos/news log --oneline -2
```
