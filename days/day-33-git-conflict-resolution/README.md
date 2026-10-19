# Day 33 — Git Conflict Resolution and Rebase

## Overview

This challenge focused on troubleshooting a rejected Git push, resolving a merge conflict, and integrating remote changes without losing existing work.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Resolve the Git push issue in the `story-blog` repository, ensure `story-index.txt` contains all four story titles, correct the spelling of “The Lion and the Mouse”, and push the updated changes to the remote repository.

## Environment

| Component | Details |
|---|---|
| Platform | KodeKloud |
| Environment | Nautilus / Stratos Datacenter |
| Technology | Git |
| Server | `ststor01` |
| User | `max` |
| Repository | `/home/max/story-blog` |
| Local branch | `master` |
| Remote branch | `origin/master` |

## Implementation

### 1. Inspect the Repository

Connected to the Storage server and checked the working tree, remote configuration, branch status, and recent commit history.

The local `master` branch contained an unpublished commit. The remote repository also contained changes that were not present locally.

### 2. Correct the Story Index

Updated `story-index.txt` to correct the typo “Mooose” to “Mouse”.

The final index contained all four story titles:

```text
1. The Lion and the Mouse
2. The Frogs and the Ox
3. The Fox and the Grapes
4. The Donkey and the Dog
```

Committed the correction using:

```bash
git add story-index.txt
git commit -m "Fix typo in story index"
```

### 3. Troubleshoot the Rejected Push

The initial push was rejected because the remote repository contained changes that were missing from the local branch.

Fetched the latest remote history:

```bash
git fetch origin
```

Inspected the commit history to identify the local and remote changes.

### 4. Rebase onto the Remote Branch

Rebased the local branch onto the latest remote history:

```bash
git rebase origin/master
```

Git reported an add/add conflict in `story-index.txt` because both histories contained versions of the file.

### 5. Resolve the Conflict

Replaced the conflicted file contents with the correct four story titles, ensuring the spelling of “The Lion and the Mouse” was correct.

Staged the resolved file:

```bash
git add story-index.txt
```

Continued the rebase:

```bash
git rebase --continue
```

Git successfully completed the rebase. The separate typo-fix commit was dropped because its changes were already included in the resolved file.

### 6. Verify and Push

Verified the repository status, story index, and recent commit history. The working tree was clean, and the local branch was ahead of `origin/master` by one commit.

Pushed the updated history:

```bash
git push origin master
```

The push succeeded, updating the remote branch from `4a4740d` to `e25f6cd`.

## Key Concepts

### Git Fetch

`git fetch origin` downloads new remote commits and updates remote-tracking references without automatically merging those changes into the current branch.

### Git Rebase

`git rebase origin/master` replays local commits on top of the latest remote branch, helping maintain a linear commit history.

### Merge Conflict Resolution

A merge conflict occurs when Git cannot automatically reconcile changes. The conflicting file must be reviewed, corrected, staged, and included when the operation continues.

### Rejected Pushes

A push may be rejected when the remote branch contains commits that the local branch does not have. Fetching the remote history and integrating those changes helps preserve other developers' work.

## DevOps Relevance

These skills are important when collaborating through Git in development and DevOps teams. They help maintain shared repositories, troubleshoot failed pushes, preserve concurrent changes, and keep version history consistent.

## What I Learned

- How to investigate a rejected Git push
- How to fetch and inspect remote changes
- How to resolve an add/add conflict
- How to rebase local commits onto a remote branch
- How to verify repository contents and history before pushing
- How to preserve multiple developers' work during collaboration

## Security Considerations

- Never commit passwords, tokens, or other secrets.
- Avoid force-pushing shared branches unless explicitly required and coordinated.
- Inspect repository status and history before rewriting commits.
- Preserve remote changes when resolving conflicts.

## Challenge Status

**Completed — Day 33/100** ✅

**KodeKloud Result Reference:** `68078704399a2462b6cc6684`
