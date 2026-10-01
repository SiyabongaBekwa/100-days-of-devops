```bash
#!/bin/bash

# Day 28 - Git Cherry-Pick
# KodeKloud 100 Days of DevOps
# Repository: /usr/src/kodekloudrepos/cluster
# Objective: Cherry-pick only "Update info.txt" from feature into master.

# Connect to the Storage server
ssh natasha@ststor01

# Navigate to the repository
cd /usr/src/kodekloudrepos/cluster

# Initial status check
# This failed because Git detected dubious ownership.
git status

# Inspect all branches
sudo git -c safe.directory=/usr/src/kodekloudrepos/cluster branch -a

# Inspect the feature branch commit history
sudo git -c safe.directory=/usr/src/kodekloudrepos/cluster log feature --oneline --decorate

# Switch to the master branch
sudo git -c safe.directory=/usr/src/kodekloudrepos/cluster checkout master

# Cherry-pick only the required feature commit
sudo git -c safe.directory=/usr/src/kodekloudrepos/cluster cherry-pick 1eb0481

# Push the updated master branch
sudo git -c safe.directory=/usr/src/kodekloudrepos/cluster push origin master
```
