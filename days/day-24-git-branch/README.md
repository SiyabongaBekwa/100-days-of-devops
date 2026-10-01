# Day 24 — Git Branch Creation

## Overview

This challenge focused on creating a new Git branch from an existing `master` branch in a project repository.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Create a new branch named:

```text
xfusioncorp_ecommerce
```

from the `master` branch of the repository:

```text
/usr/src/kodekloudrepos/ecommerce
```

The task specifically required that no changes be made to the application code.

## Environment

| Component     | Details                             |
| ------------- | ----------------------------------- |
| Platform      | KodeKloud                           |
| Environment   | Nautilus / Stratos Datacenter       |
| Server        | `ststor01`                          |
| User          | `natasha`                           |
| Repository    | `/usr/src/kodekloudrepos/ecommerce` |
| Source Branch | `master`                            |
| New Branch    | `xfusioncorp_ecommerce`             |
| Technology    | Git                                 |

## Implementation

### 1. Connect to the Storage Server

The first step was to connect to the Storage Server:

```bash
ssh natasha@ststor01
```

After authentication, the session was running as the `natasha` user on `ststor01`.

### 2. Navigate to the Repository

The repository was located at:

```bash
cd /usr/src/kodekloudrepos/ecommerce
```

The initial attempt to inspect the branches with:

```bash
git branch
```

returned a Git security error:

```text
fatal: detected dubious ownership in repository at '/usr/src/kodekloudrepos/ecommerce'
```

Git suggested adding the repository as a trusted `safe.directory`.

### 3. Investigate Repository Ownership

Instead of modifying the global Git configuration, the repository ownership was checked:

```bash
ls -ld /usr/src/kodekloudrepos/ecommerce
```

The repository was owned by:

```text
root root
```

while the active user was `natasha`.

### 4. Inspect Branches Without Changing Configuration

A temporary Git configuration was used for the individual command:

```bash
git -c safe.directory=/usr/src/kodekloudrepos/ecommerce branch
```

The repository contained:

```text
* kodekloud_ecommerce
  master
```

The required source branch was therefore confirmed as `master`.

### 5. Attempt to Create the Branch

The branch was initially created using:

```bash
git -c safe.directory=/usr/src/kodekloudrepos/ecommerce branch xfusioncorp_ecommerce master
```

This failed because `natasha` did not have permission to write to the repository's `.git` directory:

```text
fatal: cannot lock ref 'refs/heads/xfusioncorp_ecommerce':
Unable to create '/usr/src/kodekloudrepos/ecommerce/.git/refs/heads/xfusioncorp_ecommerce.lock':
Permission denied
```

### 6. Create the Branch Using `sudo`

Since the repository was owned by `root`, the Git operation was performed with elevated privileges:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/ecommerce branch xfusioncorp_ecommerce master
```

The command completed successfully.

### 7. Verify the New Branch

The repository branches were verified with:

```bash
sudo git -c safe.directory=/usr/src/kodekloudrepos/ecommerce branch
```

The final branch list was:

```text
* kodekloud_ecommerce
  master
  xfusioncorp_ecommerce
```

This confirmed that `xfusioncorp_ecommerce` was successfully created from `master`.

## Verification

The required branch exists in the repository:

```text
xfusioncorp_ecommerce
```

and was created from:

```text
master
```

No application code was modified during the task.

The repository ownership and permissions were also left unchanged.

## Key Concepts

### Git Branches

A Git branch provides an independent line of development within a repository.

Creating a feature branch allows developers to work on new functionality without making changes directly to the main development branch.

### Creating a Branch From a Specific Branch

The following command creates a branch from a specified starting point:

```bash
git branch <new-branch> <source-branch>
```

For this challenge:

```bash
git branch xfusioncorp_ecommerce master
```

### Git Safe Directory

Git can reject operations when the current user does not own the repository directory.

The `safe.directory` configuration allows Git to explicitly trust a repository path.

For this challenge, the configuration was supplied only for individual commands:

```bash
git -c safe.directory=/usr/src/kodekloudrepos/ecommerce ...
```

This avoided modifying the global Git configuration.

### Repository Permissions

The repository was owned by `root`, while the task was initially being performed as `natasha`.

Although `natasha` could read the repository, she could not create a new reference under `.git/refs/heads/`.

Using `sudo` for the required Git branch operation allowed the branch to be created without changing the repository's existing ownership or permissions.

## DevOps Relevance

Git branching is an important part of DevOps workflows because development teams commonly use branches for:

* Feature development
* Bug fixes
* Release preparation
* Code reviews
* CI/CD pipeline integration
* Controlled deployments

Understanding Git permissions and repository ownership is also useful when troubleshooting source-control operations on shared Linux servers.

## Security Considerations

No application code was changed during the challenge.

No repository ownership or permissions were modified.

Credentials used to access the KodeKloud environment are intentionally excluded from this repository.

Passwords, private keys, access tokens, and other secrets should never be committed to Git repositories.

## Challenge Reference

**KodeKloud Challenge:** Git Branch Creation

**Reference ID:** 68077aeb399a2462b6cc6678

## Challenge Status

**Completed — Day 24/100** ✅


