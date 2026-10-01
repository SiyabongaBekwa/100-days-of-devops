# Day 25 — Git Branch, Commit, Merge and Push

## Overview

This challenge focused on a complete Git feature-branch workflow, including creating a branch from `master`, adding a file, committing the change, merging the branch back into `master`, and pushing both branches to the remote repository.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

The Nautilus application development team requested the following changes to the repository:

```text
/usr/src/kodekloudrepos/demo
```

The requirements were to:

1. Create a new branch named `nautilus` from `master`.
2. Copy `/tmp/index.html` into the repository.
3. Add and commit `index.html` on the `nautilus` branch.
4. Merge `nautilus` back into `master`.
5. Push both `nautilus` and `master` to the `origin` remote.

No unrelated code changes were made.

## Environment

| Component      | Details                        |
| -------------- | ------------------------------ |
| Platform       | KodeKloud                      |
| Environment    | Nautilus / Stratos Datacenter  |
| Server         | `ststor01`                     |
| User           | `natasha`                      |
| Repository     | `/usr/src/kodekloudrepos/demo` |
| Remote         | `/opt/demo.git`                |
| Source Branch  | `master`                       |
| Feature Branch | `nautilus`                     |
| File           | `/tmp/index.html`              |
| Technology     | Git                            |

## Implementation

### 1. Connect to the Storage Server

The Storage Server was accessed from the jump host:

```bash
ssh natasha@ststor01
```

### 2. Navigate to the Repository

The repository was located at:

```bash
cd /usr/src/kodekloudrepos/demo
```

The initial `git branch` command produced a Git ownership safety error:

```text
fatal: detected dubious ownership in repository at '/usr/src/kodekloudrepos/demo'
```

The repository was owned by another user, so Git required the directory to be explicitly trusted.

Instead of modifying the global Git configuration, Git commands were executed with a temporary `safe.directory` configuration.

### 3. Verify the Existing Branch

The repository branches were checked with:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo branch
```

The result confirmed that the repository contained:

```text
* master
```

### 4. Create the `nautilus` Branch

The new branch was created from `master`:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo checkout -b nautilus master
```

The branches were then verified:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo branch
```

The result confirmed:

```text
  master
* nautilus
```

This confirmed that the working branch was now `nautilus`.

### 5. Copy `index.html`

The required file was located on the Storage Server at:

```text
/tmp/index.html
```

The initial copy attempt:

```bash
cp /tmp/index.html /usr/src/kodekloudrepos/demo/
```

failed with:

```text
Permission denied
```

Because the repository was not writable by `natasha`, the file was copied using `sudo`:

```bash
sudo cp /tmp/index.html /usr/src/kodekloudrepos/demo/
```

The file was verified with:

```bash
ls -l /usr/src/kodekloudrepos/demo/index.html
```

The resulting file was present in the repository.

### 6. Stage the File

The new file was staged on the `nautilus` branch:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo add index.html
```

The staging area was verified with:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo status
```

The status showed:

```text
On branch nautilus

Changes to be committed:
    new file:   index.html
```

### 7. Commit the Change

The file was committed with:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo commit -m "Add index.html"
```

The resulting commit was:

```text
[nautilus 0d7fe13] Add index.html
```

### 8. Switch Back to `master`

The repository was switched back to the `master` branch:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo checkout master
```

The branches were verified:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo branch
```

The result confirmed:

```text
* master
  nautilus
```

### 9. Merge `nautilus` into `master`

The feature branch was merged into `master`:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo merge nautilus
```

Git reported a successful fast-forward merge:

```text
Updating c1b69e2..0d7fe13
Fast-forward
 index.html | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 index.html
```

### 10. Push `nautilus` to Origin

The feature branch was pushed to the remote repository:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo push origin nautilus
```

The push successfully created the remote branch:

```text
[new branch] nautilus -> nautilus
```

### 11. Push `master` to Origin

The updated `master` branch was then pushed:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/demo push origin master
```

The successful result included:

```text
c1b69e2..0d7fe13  master -> master
```

## Verification

The complete Git workflow was successfully completed:

```text
master
   │
   └──► nautilus
          │
          ├── add index.html
          └── commit 0d7fe13
                   │
                   ▼
                master
                   │
                   └── fast-forward merge
                           │
                           ├── push nautilus → origin
                           └── push master → origin
```

The final remote state contained both branches:

```text
nautilus → origin/nautilus
master   → origin/master
```

The `index.html` file was successfully committed and merged into `master`.

## Key Concepts

### Feature Branch Workflow

Feature branches allow developers to work on new functionality independently from the main development branch.

In this challenge:

```text
master → nautilus → commit → merge → master
```

### Fast-Forward Merge

The merge was performed as a fast-forward because `master` had not received additional commits after `nautilus` was created.

Git therefore moved the `master` branch pointer directly to the `nautilus` commit.

### Git Remote

The repository's remote was:

```text
/opt/demo.git
```

Both branches were explicitly pushed to the remote:

```bash
git push origin nautilus
git push origin master
```

### Git Safe Directory

The repository triggered Git's `dubious ownership` protection.

Instead of changing the global configuration, the commands used:

```bash
git -c safe.directory=/usr/src/kodekloudrepos/demo
```

This supplied the trusted repository path for the individual Git operation.

## DevOps Relevance

This workflow is directly relevant to DevOps because Git branches and remote repositories are commonly integrated with:

* CI/CD pipelines
* Feature development
* Code reviews
* Automated testing
* Release workflows
* Deployment automation
* Source-control management

Understanding the complete branch-to-merge workflow is important when working with automated build and deployment pipelines.

## Security Considerations

Repository ownership and permissions were not changed.

The existing repository permissions required `sudo` for operations that needed write access.

Credentials used to access the KodeKloud environment are intentionally excluded from this repository.

Passwords, private keys, access tokens, and other secrets should never be committed to Git repositories.

## Challenge Reference

**KodeKloud Challenge:** Git Branch + Merge + Push

**Reference ID:**

```text
68077c92399a2462b6cc667b
```

## Challenge Status

**Completed — Day 25/100** ✅

