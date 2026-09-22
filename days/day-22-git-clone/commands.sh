```bash
#!/bin/bash

# Day 22 - Git Clone
# KodeKloud 100 Days of DevOps
# Server: ststor01
# User: natasha

# Clone the repository
git clone /opt/beta.git /usr/src/kodekloudrepos/beta

# Verify the cloned repository directory
ls -ld /usr/src/kodekloudrepos/beta

# Verify the configured Git remote
git -C /usr/src/kodekloudrepos/beta remote -v
```
