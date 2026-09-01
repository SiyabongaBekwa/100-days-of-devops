# Day 7 — Linux SSH Authentication

## Challenge

The objective of this challenge was to configure passwordless SSH authentication from the Nautilus Jump Host to the application servers.

The task required configuring SSH public key authentication for the required application server users and verifying that the users could connect without being prompted for a password.

## Objective

Configure SSH key-based authentication from the Jump Host user `thor` to the following application servers:

| Server    | User     | Authentication   |
| --------- | -------- | ---------------- |
| `stapp01` | `tony`   | Passwordless SSH |
| `stapp02` | `steve`  | Passwordless SSH |
| `stapp03` | `banner` | Passwordless SSH |

The final configuration allows the `thor` user on the Jump Host to connect to each application server using SSH without entering the user's password.

> **Security note:** Passwords, private SSH keys, tokens and other credentials used during the lab are intentionally excluded from this repository.

## Implementation

### 1. Access the Jump Host

The SSH configuration was performed from the Nautilus Jump Host using the `thor` user.

The working environment was:

```text
thor@jump-host
```

The SSH public key authentication was configured from this host to the application servers.

### 2. Configure Passwordless SSH for App Server 1

The first application server was `stapp01`.

The required user was `tony`.

The public SSH key was copied to the remote user's account using:

```bash
ssh-copy-id tony@stapp01
```

The `ssh-copy-id` command installs the local public SSH key into the remote user's:

```text
~/.ssh/authorized_keys
```

After the key was installed, SSH authentication was tested using:

```bash
ssh tony@stapp01
```

The connection was successful without requiring a password.

This confirmed that passwordless SSH authentication was working for:

```text
thor → tony@stapp01
```

### 3. Configure Passwordless SSH for App Server 2

The second application server was `stapp02`.

The required user was `steve`.

The public SSH key was copied to the server using:

```bash
ssh-copy-id steve@stapp02
```

The SSH connection was then tested using:

```bash
ssh steve@stapp02
```

The connection was successfully established without requiring a password.

This confirmed that passwordless SSH authentication was working for:

```text
thor → steve@stapp02
```

### 4. Configure Passwordless SSH for App Server 3

The third application server was `stapp03`.

The required user was `banner`.

The public SSH key was copied to the server using:

```bash
ssh-copy-id banner@stapp03
```

The connection was then tested using:

```bash
ssh banner@stapp03
```

The connection was successfully established without requiring a password.

This confirmed that passwordless SSH authentication was working for:

```text
thor → banner@stapp03
```

## Verification

Each configured SSH connection was tested after installing the public key.

### App Server 1

```bash
ssh tony@stapp01
```

Expected result:

```text
[tony@stapp01 ~]$
```

No password prompt should appear.

Exit the remote session with:

```bash
exit
```

### App Server 2

```bash
ssh steve@stapp02
```

Expected result:

```text
[steve@stapp02 ~]$
```

No password prompt should appear.

Exit the remote session with:

```bash
exit
```

### App Server 3

```bash
ssh banner@stapp03
```

Expected result:

```text
[banner@stapp03 ~]$
```

No password prompt should appear.

Exit the remote session with:

```bash
exit
```

## Final Configuration

The final SSH authentication configuration was:

```text
Jump Host
    |
    | SSH key authentication
    |
    +----> tony@stapp01
    |
    +----> steve@stapp02
    |
    +----> banner@stapp03
```

All three application server connections were verified successfully.

| Source           | Destination      | Result             |
| ---------------- | ---------------- | ------------------ |
| `thor@jump-host` | `tony@stapp01`   | ✅ Passwordless SSH |
| `thor@jump-host` | `steve@stapp02`  | ✅ Passwordless SSH |
| `thor@jump-host` | `banner@stapp03` | ✅ Passwordless SSH |

## Key Concepts

### SSH Key-Based Authentication

SSH supports authentication using cryptographic key pairs rather than passwords.

The client uses a private key while the corresponding public key is installed on the remote server.

### `ssh-copy-id`

`ssh-copy-id` is a utility used to install a user's public SSH key on a remote server.

For example:

```bash
ssh-copy-id tony@stapp01
```

This adds the public key to the remote user's SSH authorization configuration.

### `authorized_keys`

The remote user's authorized public keys are stored in:

```text
~/.ssh/authorized_keys
```

When an SSH connection is attempted using the corresponding private key, the server can authenticate the client using the configured public key.

### Passwordless SSH

Passwordless SSH does not mean that the connection has no authentication.

Instead, authentication is performed using SSH keys rather than requiring the user to enter the remote account password for every connection.

### SSH Automation

SSH key authentication is particularly useful for automation because scripts and automation tools can establish SSH connections without requiring an interactive password prompt.

## DevOps Relevance

SSH authentication is an important DevOps skill because DevOps engineers frequently manage multiple Linux servers remotely.

Passwordless SSH is commonly used in:

* Linux server administration
* Configuration management
* Ansible automation
* CI/CD infrastructure
* Cloud virtual machines
* Deployment automation
* Remote administration
* Infrastructure management

This challenge also provides a foundation for later Ansible tasks because Ansible commonly connects to Linux hosts using SSH.

## Security Considerations

SSH private keys must be protected.

The following information should never be committed to a public GitHub repository:

* Private SSH keys
* Passwords
* API tokens
* Cloud credentials
* Access tokens
* Secrets

This repository therefore uses placeholders and documents the commands without exposing the credentials used during the lab.

## What I Learned

* How SSH key-based authentication works
* How to use `ssh-copy-id`
* How to configure passwordless SSH access
* How public keys are used for remote authentication
* How to verify SSH authentication
* How SSH can support automation
* Why SSH keys are important for DevOps workflows
* Why credentials and private keys must be protected

## Commands

The complete command sequence used for this challenge is available in [`commands.sh`](./commands.sh).

## Challenge Status

**Completed — Day 7/100** ✅
