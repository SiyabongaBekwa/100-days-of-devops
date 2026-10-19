#!/bin/bash

# Day 33 - Git Conflict Resolution and Rebase
# KodeKloud 100 Days of DevOps
# Repository: /home/max/story-blog

# Connect to the Storage server from the jump host.
ssh max@ststor01

# Navigate to the repository.
cd /home/max/story-blog

# Inspect repository status and remote configuration.
git status
git remote -v
git branch -vv

# Inspect the story index and commit history.
cat story-index.txt
git log --oneline --decorate -5
git show --stat HEAD

# Correct the typo in the story index.
sed -i 's/The Lion and the Mooose/The Lion and the Mouse/' story-index.txt

# Commit the correction.
git add story-index.txt
git commit -m "Fix typo in story index"

# Fetch the latest remote changes.
git fetch origin

# Inspect local and remote commit history.
git log --oneline --graph --decorate --all -10

# Rebase local master onto the latest remote master.
git rebase origin/master

# If story-index.txt conflicts, replace it with the required four titles:
cat > story-index.txt <<'EOF'
1. The Lion and the Mouse
2. The Frogs and the Ox
3. The Fox and the Grapes
4. The Donkey and the Dog
EOF

# Stage the resolved file and continue the rebase.
git add story-index.txt
git rebase --continue

# Verify the final state.
git status
cat story-index.txt
git log --oneline --decorate -5

# Push the updated branch.
git push origin master

# KodeKloud result reference: 68078704399a2462b6cc6684