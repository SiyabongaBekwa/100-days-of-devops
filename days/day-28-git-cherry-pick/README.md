# Day 28 — Git Cherry-Pick

## Overview

This challenge focused on using Git cherry-pick to apply a specific commit from one branch onto another branch.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

The objective was to cherry-pick only the feature commit with the message:

```text
Update info.txt
```

from the `feature` branch into the `master` branch, then push the updated `master` branch to the remote repository.

## Environment

| Component     | Details                           |
| ------------- | --------------------------------- |
| Platform      | KodeKloud                         |
| Environment   | Nautilus / Stratos Datacenter     |
| Server        | Storage server (`ststor01`)       |
| Repository    | `/usr/src/kodekloudrepos/cluster` |
| Remote        | `origin`                          |
| Source branch | `feature`                         |
| Target branch | `master`                          |
| Technology    | Git                               |

## Implementation

The repository was located on the Storage server.

The initial `git status` command was rejected because Git detected that the repository was owned by a different user. Instead of changing the global Git configuration, the repository was accessed using Git's `safe.directory` option with `sudo`.

The available branches were inspected and the commit history of the `feature` branch was reviewed.

The required commit was identified as:

```text
1eb0481 Update info.txt
```

The repository was then switched to the `master` branch and the specific commit was cherry-picked.

The cherry-pick created a new commit on `master`:

```text
0924175 Update info.txt
```

Finally, the updated `master` branch was pushed to `origin`.

## Commands

The commands used during the challenge are documented separately in [`commands.sh`](./commands.sh).

## Cherry-Pick

Git cherry-pick applies the changes introduced by a specific existing commit to the current branch.

In this challenge, the required commit was:

```text
1eb0481 Update info.txt
```

The commit was applied while on the `master` branch:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/cluster cherry-pick 1eb0481
```

This created a new commit on `master`:

```text
0924175 Update info.txt
```

## Why Cherry-Pick Was Used

The task required only one specific commit from the `feature` branch to be included in `master`.

The `feature` branch contained another later commit:

```text
f82860e Update welcome.txt
```

Cherry-picking `1eb0481` allowed the required `Update info.txt` change to be applied without merging the entire `feature` branch.

## Key Concepts

### Git Branches

Branches allow developers to work on changes independently without immediately modifying the main development branch.

### Git Log

`git log` was used to inspect the commit history and identify the exact commit required for the task.

### Git Cherry-Pick

Cherry-pick applies the changes from a specific commit onto the current branch.

This is useful when a particular change is required without bringing in all the changes from another branch.

### Safe Directory

Git's `safe.directory` mechanism protects against operating on repositories with unexpected ownership.

The challenge was completed without changing the global Git configuration.

## DevOps Relevance

Git is a fundamental tool in DevOps workflows.

Cherry-picking can be useful when:

* Applying a specific fix to another branch
* Backporting changes
* Moving selected changes between release branches
* Managing hotfixes
* Controlling which changes enter a deployment branch

Understanding Git history and selective change management is important when working with CI/CD pipelines and production releases.

## What I Learned

* How to inspect Git branches and commit history
* How to identify a specific commit from a branch
* How to switch between Git branches
* How to cherry-pick a specific commit
* How cherry-pick differs from merging an entire branch
* How to work with Git's `safe.directory` protection
* How to push the resulting changes to a remote repository

## Security Considerations

No credentials, passwords, private keys, or access tokens are stored in this repository.

Repository access credentials should never be committed to Git repositories.

## Result

The required `Update info.txt` commit was successfully cherry-picked from `feature` into `master`.

The resulting commit was:

```text
0924175 Update info.txt
```

The updated `master` branch was successfully pushed to `origin`.


## Challenge

**Challenge Status: Completed — Day 28/100** ✅

Ref ID:

```text
680780fa399a2462b6cc667e
```
