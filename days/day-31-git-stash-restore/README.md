# Day 31 — Git Stash Restoration

## Overview

This challenge focused on locating and restoring specific stashed changes in a Git repository, committing the restored work, and pushing it to the remote repository.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Restore the changes identified by `stash@{1}` in the `/usr/src/kodekloudrepos/beta` repository on the Storage server, commit the restored changes, and push them to `origin/master`.

## Environment

| Component | Details |
|---|---|
| Platform | KodeKloud |
| Environment | Nautilus / Stratos Datacenter |
| Technology | Git |
| Server | `ststor01` |
| Repository | `/usr/src/kodekloudrepos/beta` |
| Branch | `master` |
| File restored | `welcome.txt` |

## Implementation

### 1. Connect to the Storage Server

Connected to the Storage server from the jump host using SSH.

### 2. Inspect the Stash List

Git reported a dubious ownership warning when accessing the repository. To avoid changing the global Git configuration, Git commands were run with the repository-specific setting:

`-c safe.directory=/usr/src/kodekloudrepos/beta`

The stash list contained two entries. The required entry was:

```text
stash@{1}: WIP on master: 3edbaaa initial commit
```

### 3. Restore the Required Stash

The changes were restored using `git stash apply` with the specified stash identifier.

The operation restored `welcome.txt` and left the stash entry available rather than removing it.

### 4. Commit the Changes

The restored file was committed with the message:

`Restore stashed changes`

The resulting commit was:

```text
b4f5094 Restore stashed changes
```

### 5. Push to the Remote Repository

The commit was pushed successfully to `origin/master`.

The remote branch advanced from `3edbaaa` to `b4f5094`.

## Key Concepts

### Git Stash

Git stash temporarily stores changes so that work can be resumed later without immediately committing those changes to the current branch.

### `git stash list`

Lists available stash entries, such as `stash@{0}` and `stash@{1}`.

### `git stash apply`

Restores the changes from a selected stash entry while keeping that entry in the stash list.

This differs from `git stash pop`, which attempts to restore the changes and remove the stash entry after a successful application.

### Commit and Push

After restoring the changes, a commit records them in the repository history. Pushing sends the commit to the configured remote repository so other users and systems can access it.

## DevOps Relevance

Git stash management is useful when developers need to switch tasks, preserve unfinished work, or restore changes in shared development workflows. Committing and pushing verified changes also helps keep remote repositories up to date for collaborative development and CI/CD pipelines.

## What I Learned

- How to inspect Git stash entries
- How to restore a specific stash using `git stash apply`
- How to commit restored changes
- How to push a commit to a remote branch
- How to apply a repository-specific Git safety setting without changing global configuration

## Security and Operational Considerations

- Never store passwords, access tokens, or private keys in repository documentation.
- Check the target stash identifier before applying it.
- Review restored changes before committing them.
- Confirm the target branch and remote before pushing.

## Challenge Status

**Completed — Day 31/100** ✅

**KodeKloud Result Reference:** `68078455399a2462b6cc6682`
