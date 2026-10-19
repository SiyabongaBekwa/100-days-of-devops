# Day 34 — Git Hooks and Automated Release Tagging

## Overview

This challenge focused on configuring a server-side Git hook to automate release tagging whenever changes are pushed to the `master` branch.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Merge the `feature` branch into `master`, create a `post-update` hook in the bare Git repository, test the hook, and push the changes.

The hook was configured to create a release tag using the current date whenever the `master` branch is updated.

## Environment

| Component | Details |
|---|---|
| Platform | KodeKloud |
| Environment | Nautilus / Stratos Datacenter |
| Technology | Git |
| Server | `ststor01` |
| User | `natasha` |
| Working repository | `/usr/src/kodekloudrepos/media` |
| Bare repository | `/opt/media.git` |
| Hook | `post-update` |
| Branches | `feature` and `master` |

## Implementation

### 1. Inspect the Repository

Connected to the Storage server as `natasha` and inspected the working tree, branches, commit history, repository permissions, and existing hooks.

The `feature` branch contained a commit that needed to be integrated into `master`.

The bare repository and its hooks directory were owned by `natasha`. Existing directory permissions were preserved.

### 2. Create the Post-Update Hook

Created the hook at:

```text
/opt/media.git/hooks/post-update
```

The hook checks which references were updated and creates a date-based release tag when `refs/heads/master` is included.

```bash
#!/bin/bash

for ref in "$@"; do
    if [ "$ref" = "refs/heads/master" ]; then
        tag="release-$(date +%F)"
        git --git-dir=/opt/media.git tag "$tag" refs/heads/master
    fi
done
```

Made the hook executable:

```bash
chmod +x /opt/media.git/hooks/post-update
```

Verified that the hook existed and had executable permissions.

### 3. Merge Feature into Master

Switched to the `master` branch and merged `feature`:

```bash
git checkout master
git merge feature
```

Git completed a fast-forward merge, bringing the feature commit into `master`.

### 4. Push Changes and Test the Hook

Pushed the updated `master` branch:

```bash
git push origin master
```

This updated the branch in the bare repository and triggered the `post-update` hook.

### 5. Verify the Release Tag

Listed the release tags in the bare repository:

```bash
git --git-dir=/opt/media.git tag -l 'release-*'
```

The output confirmed that the hook created:

```text
release-2026-10-14
```

## Key Concepts

### Git Hooks

Git hooks are scripts that run automatically in response to specific Git events. Server-side hooks can automate repository tasks when developers push changes.

### Post-Update Hook

The `post-update` hook runs after references in a repository are updated by a push. The script receives the updated reference names as arguments.

In this challenge, the hook checks for `refs/heads/master` before creating the release tag.

### Automated Release Tagging

The command `date +%F` generates a date in `YYYY-MM-DD` format. The hook uses this value to create a tag such as `release-2026-10-14`.

### Bare Git Repositories

A bare repository stores Git history and references without a checked-out working tree. It is commonly used as a central remote repository.

## DevOps Relevance

Automating release tagging with Git hooks demonstrates how repository events can trigger repeatable actions. Similar automation helps development and DevOps teams maintain consistent release processes and reduce manual steps.

## What I Learned

- How to configure a server-side Git hook
- How to merge a feature branch into `master`
- How to make a hook executable
- How to generate date-based release tags
- How to test a hook by pushing changes
- How to verify tags in a bare repository
- Why repository permissions should be preserved

## Security and Operational Considerations

- Preserve existing repository ownership and permissions.
- Restrict write access to server-side hooks to trusted administrators.
- Test hooks before relying on them in production.
- Consider how repeated pushes on the same day should be handled, because Git tags normally cannot be recreated at an existing name without an explicit update.

## Challenge Status

**Completed — Day 34/100** ✅

**Release Tag Created:** `release-2026-10-14`

**KodeKloud Result Reference:** `68078772399a2462b6cc6685`
