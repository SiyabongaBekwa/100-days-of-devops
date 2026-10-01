# Day 27 — Git Revert

## Overview

This challenge focused on reverting the latest Git commit in an existing repository without rewriting the repository's commit history.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Revert the latest commit (`HEAD`) in the `news` repository back to the state represented by the previous commit.

The revert had to:

1. Be performed in `/usr/src/kodekloudrepos/news`.
2. Revert the latest commit.
3. Preserve the existing Git history by creating a new revert commit.
4. Use the exact commit message `revert news`.
5. Keep the commit message in lowercase.

## Environment

| Component   | Details                        |
| ----------- | ------------------------------ |
| Platform    | KodeKloud                      |
| Environment | Nautilus / Stratos Datacenter  |
| Server      | Storage Server (`ststor01`)    |
| Repository  | `/usr/src/kodekloudrepos/news` |
| Branch      | `master`                       |
| Technology  | Git                            |

## Implementation

### 1. Connect to the Storage Server

The repository was located on the Storage Server.

```bash
ssh natasha@ststor01
```

Then the repository was opened:

```bash
cd /usr/src/kodekloudrepos/news
```

### 2. Inspect the Recent Commits

The latest two commits were checked before performing the revert:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/news log --oneline -2
```

The output showed:

```text
647f86b (HEAD -> master, origin/master) add data.txt file
3e19d39 initial commit
```

This identified:

* Latest commit: `647f86b` — `add data.txt file`
* Previous commit: `3e19d39` — `initial commit`

The latest commit was therefore the commit that needed to be reverted.

### 3. Revert the Latest Commit

The latest commit was reverted using `git revert`:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/news revert --no-edit 647f86b
```

Git created a new revert commit:

```text
[master 43715c5] Revert "add data.txt file"
```

The revert operation created a new commit rather than removing the original commit from history.

### 4. Update the Revert Commit Message

The challenge required the new commit to use the exact lowercase message:

```text
revert news
```

The revert commit was amended:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/news commit --amend -m "revert news"
```

The resulting commit was:

```text
[master 989f401] revert news
```

### 5. Verify the Commit History

The latest commits were checked again:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/news log --oneline -2
```

The final result was:

```text
989f401 (HEAD -> master) revert news
647f86b (origin/master) add data.txt file
```

This confirmed that the new revert commit was at `HEAD` and that the original commit remained in the repository history.

## Revert vs Reset

This challenge demonstrated an important difference between `git revert` and `git reset`.

### `git revert`

`git revert` creates a **new commit** that reverses the changes introduced by an earlier commit.

In this challenge:

```text
647f86b  add data.txt file
     ↓
989f401  revert news
```

The original commit remains in the history.

### `git reset`

A reset can move the branch pointer to an earlier commit and, depending on the reset mode and subsequent push, can rewrite the branch history.

That was not the required approach for this challenge.

## Key Concepts

### Git HEAD

`HEAD` represents the currently checked-out commit.

In this challenge, `HEAD` initially pointed to:

```text
647f86b
```

After the revert, `HEAD` pointed to:

```text
989f401
```

### Reverting a Commit

A revert is useful when changes need to be undone while preserving the existing commit history.

This is particularly useful in collaborative repositories where rewriting shared history can cause problems for other developers.

### Commit Amend

The `git commit --amend` command was used to replace the automatically generated revert commit message with the exact message required by the challenge.

## DevOps Relevance

Git history management is important in DevOps because source-code repositories are closely integrated with:

* CI/CD pipelines
* Release management
* Deployment workflows
* Code reviews
* Production change management
* Incident recovery

Knowing how to safely reverse a change without deleting commit history is an important version-control skill.

## What I Learned

* How to inspect recent Git commits
* How to identify the current `HEAD`
* How to revert a specific commit
* The difference between `git revert` and `git reset`
* How to amend a commit message
* How to verify Git history after a revert
* Why preserving commit history is important in collaborative environments

## Security Considerations

No passwords, private keys, access tokens, or other credentials are stored in this repository.

Sensitive authentication details used during the KodeKloud lab are intentionally excluded from the documentation.

## Challenge Result

**Completed — Day 27/100** ✅

**KodeKloud Ref ID:** `68077d2b399a2462b6cc667c`

