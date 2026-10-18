# Day 30 — Git Reset and History Cleanup

## Overview

This challenge focused on cleaning up a Git repository by resetting its commit history to a specific commit and pushing the updated history to the remote repository.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Reset the `master` branch in the `/usr/src/kodekloudrepos/blog` repository so that its history contains only these two commits:

- `initial commit`
- `add data.txt file`

Remove the subsequent test commits from the branch history and working tree, then push the updated branch to the remote repository.

## Environment

| Component | Details |
|---|---|
| Platform | KodeKloud |
| Environment | Nautilus / Stratos Datacenter |
| Technology | Git |
| Server | `ststor01` |
| Repository | `/usr/src/kodekloudrepos/blog` |
| Branch | `master` |
| Task | Git history reset and remote update |

## Implementation

### 1. Connect to the Storage Server

Connect to the Storage server from the jump host using SSH.

### 2. Inspect the Repository History

Git initially reported a dubious ownership warning when accessing the repository. Rather than changing the global Git configuration, the commands used `-c safe.directory=/usr/src/kodekloudrepos/blog` to apply the exception to individual Git commands.

The original history contained 12 commits, including ten test commits that needed to be removed from the branch history.

### 3. Reset the Branch

The target commit was identified as:

```text
69f8087 add data.txt file
```

The branch was reset to this commit using `git reset --hard`. This moved the local `master` branch back to the required commit and updated the working tree to match it.

### 4. Verify the Result

The commit history was checked again. Exactly two commits remained:

```text
69f8087 add data.txt file
e196cf2 initial commit
```

### 5. Push the Updated History

Because the reset rewrote the branch history, a normal push would not update the remote branch. The changes were pushed using `--force-with-lease`, which provides a safeguard against overwriting an unexpected remote update.

The push completed successfully, and the remote `master` branch was updated from `bb9fb5b` to `69f8087`.

## Commands

The commands used during the challenge are documented in `commands.sh`.

No passwords or other login credentials are included in this repository.

## Key Concepts

### Git Reset

`git reset --hard <commit>` moves the current branch reference to the specified commit and updates the index and working tree to match it.

**Important:** This can discard uncommitted changes and remove later commits from the current branch's history. Confirm the target commit before using it.

### Git Commit History

Git records project changes as commits. Inspecting the history helps identify the correct point to which a branch should be reset.

### Force Push

A force push updates a remote branch even when the new branch history is not a fast-forward of the remote history.

`--force-with-lease` is generally safer than `--force` because it checks that the remote branch has not changed unexpectedly since it was last observed.

### Git Repository Ownership

Git may block operations when a repository is owned by another user. The `safe.directory` setting can mark a specific repository as trusted. In this challenge, the setting was applied to individual commands instead of changing the global configuration.

## DevOps Relevance

Git history management is useful in DevOps workflows involving:

- Source control and version management
- Collaborative development
- Repository maintenance
- CI/CD pipelines
- Troubleshooting changes
- Safe management of remote branches

## What I Learned

- How to inspect Git commit history
- How to identify a target commit
- How to reset a branch and working tree
- How to verify the resulting commit history
- How to push rewritten history with `--force-with-lease`
- Why history rewrites require caution when working with shared branches

## Security and Operational Considerations

- Never include passwords, access tokens, or private keys in repository documentation.
- Verify the target commit before running a hard reset.
- Coordinate history rewrites with collaborators because they can affect other developers' local branches.
- Prefer `--force-with-lease` over `--force` when a force push is required.

## Challenge Status

**Completed — Day 30/100** ✅

**KodeKloud Result Reference:** `6807840c399a2462b6cc6681`
