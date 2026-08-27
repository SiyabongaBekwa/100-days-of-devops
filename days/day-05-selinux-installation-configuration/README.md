# Day 5 — SELinux Installation and Configuration

## Objective

The objective of this challenge was to install the required SELinux packages on the designated application server and permanently disable SELinux.

The task provided practical experience with Linux security configuration, package management, system configuration files, and security controls.

> **Security Note:** Credentials used to access the KodeKloud lab are intentionally excluded from this repository.

## Environment

* **Platform:** KodeKloud
* **Infrastructure:** Nautilus / Stratos Datacenter
* **Server:** Application Server
* **Operating System:** Linux
* **Security Framework:** SELinux

## Implementation

### 1. Connect to the Application Server

The first step was to connect to the designated application server using SSH.

```bash
ssh <user>@<server>
```

> Replace `<user>` and `<server>` with the server details provided by the lab.

### 2. Install SELinux Packages

The required SELinux packages were installed on the application server.

```bash
sudo yum install -y selinux-policy selinux-policy-targeted
```

The `-y` option automatically confirms the package installation.

### 3. Disable SELinux Permanently

The SELinux configuration file was opened:

```bash
sudo vi /etc/selinux/config
```

The following configuration was set:

```text
SELINUX=disabled
```

This configures SELinux to remain disabled after a system reboot.

### 4. Verify the Configuration

The SELinux configuration file was checked:

```bash
cat /etc/selinux/config
```

The expected configuration contains:

```text
SELINUX=disabled
```

A targeted check can also be performed using:

```bash
grep '^SELINUX=' /etc/selinux/config
```

Expected output:

```text
SELINUX=disabled
```

The current SELinux status can be inspected using:

```bash
sestatus
```

> **Note:** The challenge required SELinux to be permanently disabled. A reboot was not required as part of the task.

## Verification & Troubleshooting

### Check SELinux Configuration

Use:

```bash
grep '^SELINUX=' /etc/selinux/config
```

Expected output:

```text
SELINUX=disabled
```

### Check SELinux Status

Use:

```bash
sestatus
```

This displays the current SELinux status and configuration.

### Check Installed SELinux Packages

Use:

```bash
rpm -qa | grep selinux
```

This can be used to verify that SELinux-related packages are installed.

### Common Issues

#### Permission Denied

Ensure that the account being used has the required `sudo` privileges.

#### Configuration Not Changed

Check the configuration file:

```bash
cat /etc/selinux/config
```

Verify that it contains:

```text
SELINUX=disabled
```

#### SELinux Still Appears Enabled

Changing `/etc/selinux/config` changes the persistent configuration.

The current runtime state may not immediately change until the system is restarted.

## Key Concepts

### SELinux

Security-Enhanced Linux (SELinux) provides an additional security layer for Linux systems.

It provides mandatory access control that can restrict what users and processes are allowed to access.

### SELinux Modes

SELinux commonly operates in three modes:

* **Enforcing** — SELinux policies are actively enforced.
* **Permissive** — SELinux policies are logged but not enforced.
* **Disabled** — SELinux is completely disabled.

### Permanent Configuration

The persistent SELinux configuration is stored in:

```text
/etc/selinux/config
```

Setting:

```text
SELINUX=disabled
```

configures SELinux to remain disabled after a reboot.

### Linux Security

SELinux provides an additional security mechanism alongside traditional Linux permissions.

Understanding SELinux is useful when administering and troubleshooting Linux environments.

## DevOps Relevance

SELinux configuration is relevant when managing:

* Linux servers
* Application servers
* Cloud virtual machines
* Web servers
* Container hosts
* Automation infrastructure
* Production environments

DevOps engineers may encounter SELinux when deploying applications, configuring servers, troubleshooting access issues, and automating infrastructure.

Understanding Linux security configuration also provides a foundation for later automation using tools such as Ansible.

## What I Learned

* How SELinux is configured on Linux systems
* How to install SELinux-related packages
* How to configure SELinux to be permanently disabled
* How to inspect `/etc/selinux/config`
* How to verify SELinux status
* The difference between enforcing, permissive, and disabled modes
* Why Linux security configuration is important in DevOps environments
* The importance of verifying configuration changes

## Commands

The complete command sequence for this challenge is available in [`commands.sh`](./commands.sh).

## Challenge Status

**Completed — Day 5/100** ✅
