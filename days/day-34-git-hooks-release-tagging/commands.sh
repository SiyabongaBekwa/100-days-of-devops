#!/bin/bash

# Day 34 - Git Hooks and Automated Release Tagging
# KodeKloud 100 Days of DevOps
# Working repository: /usr/src/kodekloudrepos/media
# Bare repository: /opt/media.git

# Connect to the Storage server from the jump host.
ssh natasha@ststor01

# Navigate to the working repository.
cd /usr/src/kodekloudrepos/media

# Inspect the working tree, branches, and commit history.
git status
git branch -vv
git log --oneline --decorate --graph --all -10

# Inspect the bare repository and existing hooks.
ls -ld /opt/media.git /opt/media.git/hooks
ls -l /opt/media.git/hooks/post-update*
git remote -v
date +%F

# Create the post-update hook.
cat > /opt/media.git/hooks/post-update <<'EOF'
#!/bin/bash

for ref in "$@"; do
    if [ "$ref" = "refs/heads/master" ]; then
        tag="release-$(date +%F)"
        git --git-dir=/opt/media.git tag "$tag" refs/heads/master
    fi
done
EOF

# Make the hook executable without changing directory permissions.
chmod +x /opt/media.git/hooks/post-update

# Verify the hook.
ls -l /opt/media.git/hooks/post-update
cat /opt/media.git/hooks/post-update

# Merge feature into master.
git checkout master
git merge feature

# Push master to trigger the hook.
git push origin master

# Verify the release tag in the bare repository.
git --git-dir=/opt/media.git tag -l 'release-*'

# KodeKloud result reference: 68078772399a2462b6cc6685