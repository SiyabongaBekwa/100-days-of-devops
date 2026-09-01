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

### 1. Install Ansible

Ansible was installed using `pip3` with the required version:

```bash
pip3 install ansible==4.7.0

The installation completed successfully and installed:

ansible-4.7.0
ansible-core-2.11.12

This confirmed that the required Ansible package and its corresponding Ansible Core dependency were installed.

2. Verify the Ansible Package

The installed package was verified using:

pip3 show ansible

The important output was:

Name: ansible
Version: 4.7.0
Location: /usr/local/lib/python3.9/site-packages

This confirmed that the required Ansible package version was installed.

3. Verify the Ansible CLI

The Ansible command-line interface was verified with:

ansible --version

The output confirmed:

ansible [core 2.11.12]

It also showed:

ansible python module location = /usr/local/lib/python3.9/site-packages/ansible
executable location = /usr/local/bin/ansible
python version = 3.9.19
Ansible vs Ansible Core

The challenge required Ansible 4.7.0.

The ansible --version command reports the bundled Ansible Core version. In this installation, the core version is:

2.11.12

This does not mean that the wrong Ansible version was installed.

The installed Ansible package was confirmed separately with:

pip3 show ansible

which reported:

Version: 4.7.0

Therefore:

Ansible       = 4.7.0
Ansible Core  = 2.11.12
4. Locate the Ansible Executable

The location of the Ansible executable was checked using:

which ansible

Result:

/usr/local/bin/ansible

This confirmed that the Ansible CLI was available through the system PATH.

5. Verify Executable Permissions

The permissions of the Ansible executable were inspected with:

ls -l $(which ansible)

The result was:

-rwxr-xr-x 1 root root 6437 Aug 26 08:56 /usr/local/bin/ansible

The permission structure:

-rwxr-xr-x

indicates that:

The owner can read, write, and execute.
The group can read and execute.
Other users can read and execute.

Therefore, the Ansible executable was available for execution by users on the system.

Verification

The following commands were used to validate the installation:

pip3 show ansible
ansible --version
which ansible
ls -l $(which ansible)
Verification Results
Check	Result
Ansible package installed	✅
Required version 4.7.0	✅
Ansible Core 2.11.12	✅
Python 3.9.19	✅
Ansible executable found	✅
Global executable path	/usr/local/bin/ansible
Executable permissions	-rwxr-xr-x
Challenge requirements satisfied	✅
Key Concepts
Ansible

Ansible is an automation and configuration-management platform used to automate tasks across servers and infrastructure.

It can be used for:

Configuration management
Application deployment
Server provisioning
Infrastructure automation
Orchestration
Repetitive operational tasks
pip3

pip3 is the Python package manager used to install Python packages.

In this challenge, it was used to install the required Ansible release:

pip3 install ansible==4.7.0
Ansible Core

Ansible Core contains the core automation engine and command-line functionality used by Ansible.

In this challenge:

Ansible       = 4.7.0
Ansible Core  = 2.11.12
PATH

The system PATH determines where executable commands can be found.

The following command confirmed that the Ansible executable was available through the PATH:

which ansible

Result:

/usr/local/bin/ansible
DevOps Relevance

Installing and verifying Ansible is an important foundation for infrastructure automation.

In a DevOps environment, Ansible can be used to automate tasks such as:

Installing software across multiple servers.
Configuring Linux systems.
Managing application services.
Deploying applications.
Managing users and permissions.
Applying consistent server configurations.
Integrating infrastructure automation into CI/CD pipelines.

This challenge builds on the previous Linux and SSH tasks because Ansible commonly uses SSH to communicate with managed Linux hosts.

Security Considerations

No passwords, private SSH keys, access tokens, or other credentials should be stored in this repository.

When documenting Ansible automation:

Never commit private keys.
Never commit passwords.
Never commit API tokens.
Use Ansible Vault for sensitive variables where appropriate.
Follow the principle of least privilege.
Use dedicated automation accounts where appropriate.
What I Learned

This challenge demonstrated how to:

Install a specific Ansible release using pip3.
Verify the installed Ansible package.
Understand the relationship between Ansible and Ansible Core versions.
Verify the Ansible command-line interface.
Locate a system-wide executable using which.
Inspect Linux executable permissions using ls -l.
Validate that an automation tool is correctly installed before using it in infrastructure workflows.
Commands

The commands used during this challenge are documented separately in:

commands.sh

Challenge Status

Completed — Day 8/100 ✅