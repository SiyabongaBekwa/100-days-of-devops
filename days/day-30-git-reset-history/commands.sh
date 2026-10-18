```bash
#!/bin/bash

# Day 30 - Git Reset and History Cleanup
# KodeKloud 100 Days of DevOps
# Repository: /usr/src/kodekloudrepos/blog
# Objective: Keep only the initial commit and add data.txt file commit.

# Connect to the Storage server from the jump host.
ssh natasha@ststor01

# Navigate to the repository.
cd /usr/src/kodekloudrepos/blog

# Inspect the original commit history.
sudo git -c safe.directory=/usr/src/kodekloudrepos/blog log --oneline --decorate

# Reset master to the required commit.
sudo git -c safe.directory=/usr/src/kodekloudrepos/blog reset --hard 69f8087

# Verify that only the two required commits remain.
sudo git -c safe.directory=/usr/src/kodekloudrepos/blog log --oneline --decorate

# Push the rewritten history to the remote repository.
sudo git -c safe.directory=/usr/src/kodekloudrepos/blog push --force-with-lease origin master

# Expected final history:
# 69f8087 add data.txt file
# e196cf2 initial commit

# KodeKloud result reference:
# 6807840c399a2462b6cc6681
```