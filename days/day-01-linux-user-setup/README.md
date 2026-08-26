# Day 1 — Linux User Setup with Non-Interactive Shell

## Overview

This challenge focused on Linux user management and configuring a user account with a non-interactive shell.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Create a Linux user account and configure it to use a non-interactive shell.

The purpose of this task was to practice basic Linux account management and understand how shell configuration can control interactive access to a server.

## Environment

| Component   | Details                       |
| ----------- | ----------------------------- |
| Platform    | KodeKloud                     |
| Environment | Nautilus / Stratos Datacenter |
| Technology  | Linux                         |
| Task        | Linux User Management         |
| Shell       | Non-interactive shell         |

## Implementation

### 1. Connect to the Application Server

The first step was to connect to the designated application server using SSH.

```bash
ssh <user>@<server>
```

> Credentials are intentionally excluded from this repository.

### 2. Create the Linux User

The user was created using:

```bash
sudo useradd -m -s /usr/sbin/nologin <username>
```

The options used were:

| Option              | Purpose                                         |
| ------------------- | ----------------------------------------------- |
| `-m`                | Creates the user's home directory under `/home` |
| `-s`                | Specifies the user's login shell                |
| `/usr/sbin/nologin` | Prevents normal interactive shell access        |

### 3. Verify the Account

The account configuration was checked using:

```bash
cat /etc/passwd
```

A more targeted check can be performed with:

```bash
grep '<username>' /etc/passwd
```

The expected account entry contains:

```text
<username>:x:<UID>:<GID>::/home/<username>:/usr/sbin/nologin
```

The important part is:

```text
/usr/sbin/nologin
```

which confirms that the account has been configured with a non-interactive shell.

### 4. Test Interactive Access

The configuration was tested by attempting to switch to the account:

```bash
sudo su <username>
```

The expected result is:

```text
This account is currently not available.
```

This provides practical verification that the account cannot be used as a normal interactive shell account.

## Verification & Troubleshooting

### Common Issues

#### Permission denied

Ensure that the account performing the operation has the required `sudo` privileges.

#### User already exists

Check whether the username already exists:

```bash
cat /etc/passwd | grep '<username>'
```

#### Shell not found

Verify that the configured shell exists:

```bash
ls -l /usr/sbin/nologin
```

### Additional Commands

List users configured with a non-interactive `nologin` shell:

```bash
grep nologin /etc/passwd
```

Check the user's UID and group membership:

```bash
id <username>
```

Remove the user and its home directory if cleanup is required:

```bash
sudo userdel -r <username>
```

## Commands

The complete command sequence for this challenge is available in [`commands.sh`](./commands.sh).


## Key Concepts

### Linux User Management

Linux user accounts control access to files, processes, services, and system resources.

User management is a fundamental Linux administration skill because automated systems and services often require dedicated accounts.

### Non-Interactive Shells

A non-interactive shell prevents an account from being used for a normal interactive terminal session.

This is useful for accounts intended for automation or service-related purposes where interactive access is not required.

### Principle of Least Privilege

Restricting unnecessary interactive access supports the principle of least privilege by limiting an account's access to what is required for its intended purpose.

## DevOps Relevance

Linux user and access management are foundational skills for working with:

* Linux servers
* Application servers
* Automation infrastructure
* CI/CD environments
* Cloud virtual machines
* Container hosts

These concepts also provide a foundation for later DevOps technologies such as SSH, Ansible, Docker, Kubernetes, and cloud infrastructure.

## What I Learned

* How to create and configure Linux user accounts
* The difference between interactive and non-interactive shells
* How restricted accounts can be used for automation and service purposes
* Basic Linux access-control principles
* The importance of verifying configuration changes

## Security Considerations

No credentials are stored in this repository.

Passwords, private keys, access tokens, and other secrets should never be committed to Git repositories.

When documenting commands, sensitive values should be replaced with placeholders such as `<username>` rather than recorded in public files.

## Challenge Status

**Completed — Day 1/100** ✅


