# Day 8 — Install Ansible

## Challenge

Install **Ansible 4.7.0** on the Nautilus jump host and verify that the installation is available system-wide.

## Objective

The objective of this challenge was to:

- Install Ansible version `4.7.0`.
- Install Ansible using `pip3`.
- Verify the installed Ansible package version.
- Verify the Ansible command-line interface.
- Confirm the global location of the Ansible executable.
- Confirm that the Ansible executable has the required permissions.

---

## Environment

| Component | Details |
|---|---|
| Host | `jump-host` |
| User | `thor` |
| Operating System | Red Hat-based Linux environment |
| Python | `3.9.19` |
| Package Manager | `pip3` |
| Ansible | `4.7.0` |
| Ansible Core | `2.11.12` |

---

## Implementation

### 1. Install Ansible 4.7.0

Ansible was installed using `pip3` with the required version:

```bash
pip3 install ansible==4.7.0
```

The installation completed successfully and installed:

```text
ansible-4.7.0
ansible-core-2.11.12
```

This confirmed that the required Ansible package and its corresponding Ansible Core dependency were installed.

---

### 2. Verify the Installed Ansible Package

The installed Ansible package was verified using:

```bash
pip3 show ansible
```

The important output was:

```text
Name: ansible
Version: 4.7.0
Location: /usr/local/lib/python3.9/site-packages
```

This confirmed that the required Ansible version was installed successfully.

---

### 3. Verify the Ansible Command-Line Interface

The Ansible command-line interface was verified using:

```bash
ansible --version
```

The output confirmed:

```text
ansible [core 2.11.12]
```

Additional information included:

```text
ansible python module location = /usr/local/lib/python3.9/site-packages/ansible
executable location = /usr/local/bin/ansible
python version = 3.9.19
```

The challenge required Ansible version `4.7.0`.

The `ansible --version` command displays the bundled Ansible Core version, which in this installation was:

```text
2.11.12
```

The Ansible package version was verified separately using:

```bash
pip3 show ansible
```

The result confirmed:

```text
Version: 4.7.0
```

Therefore, the installed versions were:

| Component    | Version   |
| ------------ | --------- |
| Ansible      | `4.7.0`   |
| Ansible Core | `2.11.12` |

---

### 4. Locate the Ansible Executable

The location of the Ansible executable was checked using:

```bash
which ansible
```

The result was:

```text
/usr/local/bin/ansible
```

This confirmed that the Ansible command was available through the system `PATH`.

---

### 5. Verify Executable Permissions

The permissions of the Ansible executable were checked using:

```bash
ls -l $(which ansible)
```

The result was:

```text
-rwxr-xr-x 1 root root 6437 Aug 26 08:56 /usr/local/bin/ansible
```

The permission structure:

```text
-rwxr-xr-x
```

means:

* The owner can read, write, and execute the file.
* The group can read and execute the file.
* Other users can read and execute the file.

This confirmed that the Ansible executable was available for execution.

---

## Verification

The following commands were used to verify the installation:

```bash
pip3 show ansible
ansible --version
which ansible
ls -l $(which ansible)
```

### Verification Results

| Check                            | Result                   |
| -------------------------------- | ------------------------ |
| Ansible package installed        | ✅                        |
| Required version `4.7.0`         | ✅                        |
| Ansible Core `2.11.12`           | ✅                        |
| Python `3.9.19`                  | ✅                        |
| Ansible executable found         | ✅                        |
| Global executable path           | `/usr/local/bin/ansible` |
| Executable permissions           | `-rwxr-xr-x`             |
| Challenge requirements satisfied | ✅                        |

---

## Final Configuration

After completing the challenge, the jump host had the following configuration:

| Component           | Configuration            |
| ------------------- | ------------------------ |
| Host                | `jump-host`              |
| User                | `thor`                   |
| Ansible Version     | `4.7.0`                  |
| Ansible Core        | `2.11.12`                |
| Python Version      | `3.9.19`                 |
| Installation Method | `pip3`                   |
| Ansible Executable  | `/usr/local/bin/ansible` |
| Installation Status | Completed                |

---

## Key Concepts

### Ansible

Ansible is an automation and configuration-management tool used to automate tasks across servers and infrastructure.

It can be used for:

* Configuration management
* Application deployment
* Server provisioning
* Infrastructure automation
* Orchestration
* Repetitive operational tasks

### pip3

`pip3` is the Python package manager used to install Python packages.

In this challenge, it was used to install the required Ansible version:

```bash
pip3 install ansible==4.7.0
```

### Ansible Core

Ansible is distributed with Ansible Core, which contains the core automation engine and command-line functionality.

For this installation:

```text
Ansible: 4.7.0
Ansible Core: 2.11.12
```

### PATH

The Linux `PATH` environment variable determines where executable commands can be found.

The following command confirmed that Ansible was available through the system `PATH`:

```bash
which ansible
```

Result:

```text
/usr/local/bin/ansible
```

---

## DevOps Relevance

Installing and verifying Ansible is an important foundation for infrastructure automation.

In a DevOps environment, Ansible can be used to automate tasks such as:

* Installing software across multiple servers.
* Configuring Linux systems.
* Managing application services.
* Deploying applications.
* Managing users and permissions.
* Applying consistent server configurations.
* Integrating infrastructure automation into CI/CD pipelines.

This challenge builds on the previous Linux and SSH tasks because Ansible commonly uses SSH to communicate with managed Linux hosts.

---

## Security Considerations

No passwords, private SSH keys, access tokens, or other sensitive credentials should be stored in this repository.

When documenting Ansible automation:

* Never commit private keys.
* Never commit passwords.
* Never commit API tokens.
* Use Ansible Vault for sensitive variables where appropriate.
* Follow the principle of least privilege.
* Use dedicated automation accounts where appropriate.

---

## What I Learned

This challenge demonstrated how to:

* Install a specific Ansible release using `pip3`.
* Verify the installed Ansible package.
* Understand the relationship between Ansible and Ansible Core versions.
* Verify the Ansible command-line interface.
* Locate a system-wide executable using `which`.
* Inspect Linux executable permissions using `ls -l`.
* Validate that an automation tool is correctly installed before using it in infrastructure workflows.

---

## Commands

The commands used during this challenge are documented separately in:

[`commands.sh`](./commands.sh)

---

## Challenge Status

**Completed — Day 8/100** ✅
