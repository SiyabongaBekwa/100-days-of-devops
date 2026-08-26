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

The task involved configuring a Linux user account with a non-interactive login shell.

The implementation consisted of:

1. Accessing the appropriate Nautilus server.
2. Creating or configuring the required Linux user.
3. Assigning a non-interactive shell to the account.
4. Verifying the resulting account configuration.

> **Security note:** Credentials used to access the KodeKloud lab are intentionally excluded from this repository.

## Commands

The exact commands used during the lab session are documented in command.sh file without passwords, private keys, tokens, or other sensitive credentials.

## Verification

The final configuration was verified by checking the user's entry in `/etc/passwd`.

The account was configured with a non-interactive shell, such as:

```text
/sbin/nologin
```

This prevents the account from being used for a normal interactive terminal session. The account was not configured with a standard interactive shell such as:

```text
/bin/bash
```

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


