# Day 26 — Git Remote Configuration, Commit and Push

## Overview

This challenge focused on Git remote management, committing changes to the `master` branch, and pushing the branch to a newly configured remote repository.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Update the Git configuration for the `beta` repository by:

1. Adding a new remote named `dev_beta`.
2. Pointing `dev_beta` to `/opt/xfusioncorp_beta.git`.
3. Copying `/tmp/index.html` into the repository.
4. Adding and committing the file to the `master` branch.
5. Pushing `master` to the new `dev_beta` remote.

## Environment

| Component       | Details                        |
| --------------- | ------------------------------ |
| Platform        | KodeKloud                      |
| Environment     | Nautilus / Stratos Datacenter  |
| Server          | Storage Server (`ststor01`)    |
| Repository      | `/usr/src/kodekloudrepos/beta` |
| Original Remote | `/opt/beta.git`                |
| New Remote      | `/opt/xfusioncorp_beta.git`    |
| Branch          | `master`                       |
| Technology      | Git                            |

## Implementation

### 1. Connect to the Storage Server

The repository was located on the Storage Server.

```bash
ssh natasha@ststor01
```

Then the repository was opened:

```bash
cd /usr/src/kodekloudrepos/beta
```

### 2. Verify the Current Branch

The repository was checked to confirm that work was being performed on `master`.

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/beta branch
```

Output:

```text
* master
```

### 3. Add the New Git Remote

A new remote named `dev_beta` was added and pointed to the required repository:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/beta remote add dev_beta /opt/xfusioncorp_beta.git
```

The configured remotes were then verified:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/beta remote -v
```

The repository contained:

```text
dev_beta        /opt/xfusioncorp_beta.git (fetch)
dev_beta        /opt/xfusioncorp_beta.git (push)
origin          /opt/beta.git (fetch)
origin          /opt/beta.git (push)
```

This confirmed that the new remote was configured alongside the existing `origin` remote.

### 4. Copy `index.html` into the Repository

The supplied file was copied into the repository:

```bash
sudo cp /tmp/index.html /usr/src/kodekloudrepos/beta/
```

The file was verified with:

```bash
ls -l /usr/src/kodekloudrepos/beta/index.html
```

The file was successfully present in the repository.

### 5. Stage the File

The new file was added to Git:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/beta add index.html
```

The staged change was verified:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/beta status
```

The status showed:

```text
On branch master

Changes to be committed:
        new file:   index.html
```

### 6. Commit the File

The file was committed to the `master` branch:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/beta commit -m "Add index.html"
```

The resulting commit was:

```text
[master cfae638] Add index.html
```

### 7. Push `master` to the New Remote

Finally, the `master` branch was pushed to `dev_beta`:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/beta push dev_beta master
```

The push successfully created the `master` branch on the new remote:

```text
[new branch] master -> master
```

## Key Concepts

### Git Remotes

A Git remote is a reference to another repository where changes can be fetched from or pushed to.

This repository initially had:

```text
origin -> /opt/beta.git
```

A second remote was added:

```text
dev_beta -> /opt/xfusioncorp_beta.git
```

Multiple remotes can be useful when a project needs to interact with more than one repository.

### Remote Management

The `git remote` command can be used to manage repository connections.

For example:

```bash
git remote -v
```

displays the configured fetch and push URLs.

### Branch Management

The changes were committed directly to the existing `master` branch.

The branch was verified before making changes to ensure that the required work was performed on the correct branch.

### Git Push

The following command pushed the local `master` branch to the newly configured remote:

```bash
git push dev_beta master
```

The remote name and branch name explicitly identify where the changes should be sent.

## DevOps Relevance

Git remote management is important in DevOps environments because repositories are commonly integrated with:

* CI/CD pipelines
* Deployment automation
* Source-code management platforms
* Build servers
* Multiple development repositories
* Internal and external Git servers

Understanding how to configure and use multiple Git remotes helps when working with distributed development and deployment workflows.

## What I Learned

* How to add a new Git remote
* How to verify configured Git remotes
* How to work with multiple remotes in one repository
* How to stage and commit changes to `master`
* How to push a specific branch to a specific remote
* How Git repositories can be connected to different repository locations

## Security Considerations

No passwords, private keys, access tokens, or other credentials are stored in this repository.

Repository paths and usernames used in the lab are documented only where necessary to explain the technical workflow.

## Challenge Result

**Completed — Day 26/100** ✅

**KodeKloud Ref ID:** `68077d2b399a2462b6cc667c`

