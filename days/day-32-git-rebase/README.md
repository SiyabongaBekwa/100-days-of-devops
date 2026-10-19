# Day 32 — Git Rebase

## Overview

This challenge focused on rebasing a feature branch onto the latest master branch while preserving feature work and avoiding an unnecessary merge commit.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Rebase the `feature` branch onto `master` in the `/usr/src/kodekloudrepos/games` repository on the Storage server, preserve the feature changes, and push the updated branch to the remote repository.

## Environment

| Component | Details |
|---|---|
| Platform | KodeKloud |
| Environment | Nautilus / Stratos Datacenter |
| Technology | Git |
| Server | `ststor01` |
| Repository | `/usr/src/kodekloudrepos/games` |
| Feature branch | `feature` |
| Base branch | `master` |

## Implementation

### 1. Connect to the Storage Server

Connected to the Storage server from the jump host using SSH and navigated to the `games` repository.

### 2. Inspect the Branches and History

The working tree was clean, and the initial branch history showed that `feature` and `master` had diverged from the same initial commit.

Initial commits:

```text
b4a0d1d Add new feature
d176ab3 Update info.txt
8a6725b initial commit
```

Git reported a dubious ownership warning when accessing the repository. To avoid changing the global Git configuration, commands used the repository-specific setting:

`-c safe.directory=/usr/src/kodekloudrepos/games`

### 3. Rebase the Feature Branch

While on `feature`, the branch was rebased onto `master`:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/games rebase master
```

Git replayed the feature commit on top of the updated master branch, creating a new commit hash while preserving the feature work.

### 4. Verify the Rebased History

The resulting history was:

```text
b7a6949 Add new feature
d176ab3 Update info.txt
8a6725b initial commit
```

This confirmed that the feature branch was now based on `master` in a straight-line history without an additional merge commit.

### 5. Push the Rebased Branch

Because rebasing changed the feature commit hash, the remote branch needed to be updated. The rebased branch was pushed using `--force-with-lease`.

The push succeeded, updating `origin/feature` from `b4a0d1d` to `b7a6949`.

## Key Concepts

### Git Rebase

`git rebase` replays commits from one branch onto another base commit. It can create a linear history and avoid a merge commit when integrating changes.

### Merge vs. Rebase

- **Merge:** Combines branch histories and may create a merge commit.
- **Rebase:** Replays commits onto a new base, producing new commit hashes for the replayed commits.

### Force Push After Rebasing

Rebasing rewrites commit history. When the remote branch contains the previous history, a regular push may be rejected.

`--force-with-lease` is safer than `--force` because it checks whether the remote branch has changed unexpectedly before updating it.

## DevOps Relevance

Git rebase is useful in collaborative software development and DevOps workflows where teams maintain feature branches, integrate upstream changes, and keep commit history clear for code reviews and release management.

## What I Learned

- How to inspect branches and commit history
- How to rebase a feature branch onto `master`
- How rebasing preserves feature work while changing commit hashes
- How to verify a linear commit history
- How to update a remote branch safely after rebasing

## Security and Operational Considerations

- Never store passwords, access tokens, or private keys in repository documentation.
- Check the working tree and branch history before rebasing.
- Coordinate history rewrites when other developers share the branch.
- Prefer `--force-with-lease` over `--force` when updating a rebased remote branch.

## Challenge Status

**Completed — Day 32/100** ✅

**KodeKloud Result Reference:** `6807867b399a2462b6cc6683`
