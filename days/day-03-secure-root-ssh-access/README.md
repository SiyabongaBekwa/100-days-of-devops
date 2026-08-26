# Day 3 — Secure Root SSH Access

## Challenge

Configure the Linux application servers to prevent direct SSH access to the `root` account.

## Objective

The objective of this challenge was to improve SSH security by disabling direct remote login for the Linux `root` user.

Instead of allowing administrators to connect directly as `root`, users should authenticate with an appropriate account and use `sudo` when elevated privileges are required.

This challenge provided practical experience with:

* SSH configuration
* Linux root access
* The SSH daemon configuration
* `sshd_config`
* `PermitRootLogin`
* Configuration verification
* Secure remote administration

## Environment

| Item             | Details                       |
| ---------------- | ----------------------------- |
| Platform         | KodeKloud                     |
| Environment      | Nautilus / Stratos Datacenter |
| Target           | Application Servers           |
| Configuration    | SSH daemon                    |
| Security Control | Disable direct root SSH login |
| Completed        | 2026-08-20                    |

> Credentials, passwords, private keys, IP addresses and other sensitive lab information are intentionally excluded from this repository.

## Implementation

### 1. Connect to the Application Server

The first step was to connect to the designated application server using SSH.

```bash
ssh <user>@<server>
```

The configuration was performed using an account with the required administrative privileges.

### 2. Inspect the SSH Configuration

The SSH daemon configuration is stored in:

```text
/etc/ssh/sshd_config
```

The current root login configuration can be checked using:

```bash
sudo grep -i "^PermitRootLogin" /etc/ssh/sshd_config
```

The configuration controls whether the SSH daemon permits direct login as the `root` user.

### 3. Disable Direct Root SSH Login

The SSH configuration was updated to disable direct root login.

The required configuration is:

```text
PermitRootLogin no
```

The setting can be updated using an editor such as:

```bash
sudo vi /etc/ssh/sshd_config
```

Locate the `PermitRootLogin` directive and configure it as:

```text
PermitRootLogin no
```

> Configuration files should be edited carefully because an incorrect SSH configuration can prevent remote access to a server.

### 4. Verify the SSH Configuration

Before applying the configuration, the SSH daemon configuration should be validated.

```bash
sudo sshd -t
```

A successful validation produces no output.

This is an important operational step because it helps identify configuration syntax errors before restarting the SSH service.

### 5. Restart or Reload the SSH Service

After validating the configuration, the SSH service can be reloaded so that the configuration change takes effect.

On systems using `systemd`:

```bash
sudo systemctl reload sshd
```

If the distribution uses the service name `ssh`:

```bash
sudo systemctl reload ssh
```

The SSH service status can be checked using:

```bash
sudo systemctl status sshd
```

or:

```bash
sudo systemctl status ssh
```

### 6. Verify the Configuration

The final configuration can be checked with:

```bash
sudo grep -i "^PermitRootLogin" /etc/ssh/sshd_config
```

The expected configuration is:

```text
PermitRootLogin no
```

This confirms that direct root SSH authentication has been disabled.

## Verification & Troubleshooting

### Validate SSH Configuration

Always validate the SSH configuration before reloading or restarting the service:

```bash
sudo sshd -t
```

If the command produces no output, the configuration syntax is valid.

### Check the SSH Service

Check whether the SSH daemon is running:

```bash
sudo systemctl status sshd
```

On systems using the `ssh` service name:

```bash
sudo systemctl status ssh
```

### Check the Effective Root Login Configuration

The configuration file can be searched using:

```bash
sudo grep -i "PermitRootLogin" /etc/ssh/sshd_config
```

The expected configuration is:

```text
PermitRootLogin no
```

### Common Issue — SSH Service Name

Different Linux distributions may use different service names.

For example:

```bash
sudo systemctl status ssh
```

or:

```bash
sudo systemctl status sshd
```

Use the service name appropriate for the target operating system.

### Common Issue — SSH Configuration Error

If:

```bash
sudo sshd -t
```

returns an error, review the configuration file for incorrect syntax or invalid directives before reloading the SSH service.

### Important Operational Consideration

When modifying SSH configuration on a remote server, maintain the current SSH session until the new configuration has been validated and confirmed.

This reduces the risk of being locked out of the server because of an incorrect SSH configuration.

## Key Concepts

### SSH

Secure Shell (SSH) is a protocol used to securely access and administer remote systems.

It is commonly used by DevOps engineers to manage:

* Linux servers
* Cloud virtual machines
* Application servers
* Infrastructure environments
* Automation hosts

### Root Account

The `root` account is the Linux superuser and has unrestricted administrative privileges.

Because of its extensive permissions, direct remote access to the root account should be restricted where possible.

### PermitRootLogin

`PermitRootLogin` is an OpenSSH server configuration directive that controls whether the root account can log in through SSH.

For this challenge, it was configured as:

```text
PermitRootLogin no
```

### Principle of Least Privilege

Disabling direct root SSH access supports the principle of least privilege.

Administrators can authenticate using their individual accounts and elevate privileges only when necessary through `sudo`.

This provides better control over administrative access.

### SSH Hardening

SSH hardening involves reducing unnecessary or insecure remote access options.

Examples include:

* Disabling direct root login
* Using key-based authentication
* Restricting unnecessary users
* Managing SSH configuration securely
* Monitoring authentication activity

## DevOps Relevance

SSH security is highly relevant to DevOps because engineers frequently work with remote infrastructure.

This includes:

* Linux application servers
* Cloud virtual machines
* Build servers
* CI/CD infrastructure
* Kubernetes nodes
* Infrastructure management hosts
* Development and testing environments

A secure SSH configuration reduces the risk of unauthorized administrative access while maintaining controlled remote management.

SSH configuration is also commonly managed through automation and configuration-management tools such as Ansible.

## Security Considerations

Disabling direct root SSH access provides several security benefits.

### Individual Accountability

Using individual user accounts instead of a shared root account makes administrative activity easier to attribute to a specific user.

### Reduced Attack Surface

Preventing direct root authentication removes one method of attempting to gain unrestricted administrative access through SSH.

### Controlled Privilege Escalation

Administrators can use:

```bash
sudo <command>
```

when elevated privileges are required.

This separates normal user access from administrative privileges.

## What I Learned

* How SSH remote access is configured on Linux
* Where the OpenSSH server configuration is located
* How `PermitRootLogin` controls direct root SSH access
* How to disable direct root SSH login
* How to validate SSH configuration using `sshd -t`
* How to check the SSH service status
* Why SSH hardening is important
* How the principle of least privilege applies to remote administration
* Why configuration changes should be validated before restarting a critical service

## Commands

The complete command workflow for this challenge is available in [`commands.sh`](./commands.sh).

The script contains the commands used for:

* Connecting to the server
* Inspecting SSH configuration
* Updating root login settings
* Validating the SSH configuration
* Checking the SSH service
* Verifying the final configuration

No passwords, private keys, tokens or other sensitive credentials are stored in the script.

## Challenge Status

**Completed — Day 3/100** ✅
