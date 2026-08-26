# Day 2 — Temporary User Setup with Expiry

## Challenge

Create a temporary Linux user account on the designated application server and configure the account with an expiry date.

## Objective

The objective of this challenge was to practice Linux user management and account lifecycle configuration.

The task required creating the user `kirsty` on **App Server 3** and configuring the account to expire on **2027-01-28**.

## Environment

| Item | Details |
|---|---|
| Platform | KodeKloud |
| Datacenter | Stratos Datacenter |
| Server | App Server 3 |
| Username | `kirsty` |
| Account Expiry | `2027-01-28` |
| Completed | 2026-08-19 |

> Credentials and other sensitive lab information are intentionally excluded from this repository.

## Implementation

### 1. Connect to the Application Server

The first step was to connect to the designated application server using SSH.

```bash
ssh <user>@<server>
2. Create the Temporary User

The user account was created with an expiry date.

sudo useradd -e 2027-01-28 kirsty

The -e option specifies the account expiration date.

3. Verify the User

The account was verified using:

id kirsty

The account information can also be checked using:

getent passwd kirsty
4. Verify the Account Expiry

The configured expiry date can be checked using:

sudo chage -l kirsty

The output should show:

Account expires : Jan 28, 2027
Verification & Troubleshooting
User Already Exists

Check whether the user already exists:

getent passwd kirsty
Check Account Expiration

Use:

sudo chage -l kirsty

This displays the account aging and expiration information.

Check User Identity

Use:

id kirsty

This confirms that the user account exists and displays its UID and group information.

Key Concepts
Temporary User Accounts

Linux accounts can be configured with an expiration date so that access automatically becomes invalid after a specified date.

This is useful for temporary employees, contractors, testing accounts, or other users who should only have access for a defined period.

Account Expiration

The account expiration date determines when the user's account becomes inactive.

Using an expiration date helps administrators manage account lifecycles without relying entirely on manual account removal.

User Lifecycle Management

User creation and account expiration are important parts of Linux system administration.

Proper account lifecycle management helps prevent unnecessary accounts from remaining active indefinitely.

DevOps Relevance

Temporary accounts and account expiration are relevant when managing:

Linux servers
Application servers
Cloud virtual machines
Development environments
CI/CD infrastructure
Temporary engineering access
Contractor access

Automating account creation and expiration can also become part of configuration management and infrastructure automation using tools such as Ansible.

What I Learned
How to create a Linux user account
How to configure an account expiration date
How to verify Linux user accounts
How to inspect account aging information
Why account lifecycle management is important
How temporary access can be controlled through account expiration
Commands

The complete command sequence for this challenge is available in commands.sh.

Challenge Status

Completed — Day 2/100 ✅