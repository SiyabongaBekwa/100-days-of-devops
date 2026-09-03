# Day 10 — Ecommerce Archive

## Challenge

The Nautilus development team required an automated solution to archive the ecommerce application files and transfer the resulting archive to the central storage server.

The task was to create a Bash script on the application server that would:

* Archive the ecommerce application directory.
* Store the archive locally in `/archives/`.
* Copy the archive to the storage server.
* Use passwordless SSH/SCP authentication.
* Ensure the script is executable.
* Verify that the archive was successfully created and transferred.

## Objective

The objective of this challenge was to:

* Install the `zip` utility.
* Create an automated Bash archive script.
* Archive `/var/www/html/ecommerce`.
* Create the archive as `xfusioncorp_ecommerce.zip`.
* Store the archive in `/archives/`.
* Transfer the archive to `ststor01`.
* Use passwordless SSH/SCP authentication.
* Verify the archive contents and remote file.

## Environment

| Component           | Configuration                         |
| ------------------- | ------------------------------------- |
| Application Server  | `stapp02`                             |
| Application User    | `steve`                               |
| Ecommerce Directory | `/var/www/html/ecommerce`             |
| Script              | `/scripts/ecommerce_archive.sh`       |
| Local Archive       | `/archives/xfusioncorp_ecommerce.zip` |
| Storage Server      | `ststor01`                            |
| Storage User        | `natasha`                             |
| Remote Archive      | `/archives/xfusioncorp_ecommerce.zip` |
| Archive Utility     | `zip`                                 |
| Transfer Method     | `scp`                                 |

---

## Implementation

### 1. Install the Zip Utility

The `zip` utility was installed on the application server so that the ecommerce directory could be compressed into a ZIP archive.

```bash
sudo yum install zip -y
```

The installation provides the `zip` command required by the archive script.

---

### 2. Create the Archive Script

The required script was created at:

```text
/scripts/ecommerce_archive.sh
```

The script was designed to automate both the archive creation and transfer process.

The script contains:

```bash
#!/bin/bash

zip -r /archives/xfusioncorp_ecommerce.zip /var/www/html/ecommerce

scp /archives/xfusioncorp_ecommerce.zip natasha@ststor01:/archives/
```

The first command recursively archives the ecommerce directory.

The second command transfers the generated archive to the central storage server using SCP.

---

### 3. Make the Script Executable

The script was given execute permission so that it could be run directly.

```bash
chmod +x /scripts/ecommerce_archive.sh
```

The resulting permissions were verified as:

```text
-rwxr-xr-x 1 steve steve 149 /scripts/ecommerce_archive.sh
```

The `x` permissions indicate that the script is executable.

---

### 4. Run the Archive Script

The script was executed directly from the application server.

```bash
/scripts/ecommerce_archive.sh
```

The script created the ZIP archive from the ecommerce directory.

The archive contained:

```text
var/www/html/ecommerce/
var/www/html/ecommerce/index.html
var/www/html/ecommerce/.gitkeep
```

The archive was created as:

```text
/archives/xfusioncorp_ecommerce.zip
```

---

### 5. Transfer the Archive

After creating the archive, the script used `scp` to transfer it to the storage server.

```bash
scp /archives/xfusioncorp_ecommerce.zip natasha@ststor01:/archives/
```

Passwordless SSH authentication was already configured, so the transfer completed without an interactive password prompt.

The remote destination was:

```text
ststor01:/archives/
```

---

### 6. Verify the Remote Archive

The archive was verified on the storage server using SSH.

```bash
ssh natasha@ststor01 "ls -lh /archives/xfusioncorp_ecommerce.zip"
```

The resulting output confirmed that the archive existed on the storage server:

```text
-rw-r--r-- 1 natasha natasha 623 Aug 28 21:45 /archives/xfusioncorp_ecommerce.zip
```

This confirmed that the file was successfully transferred.

---

## Verification

The implementation was verified at multiple stages.

### Script Permissions

The archive script was confirmed to be executable:

```text
-rwxr-xr-x 1 steve steve 149 /scripts/ecommerce_archive.sh
```

### Archive Creation

Running the script produced the ZIP archive:

```text
xfusioncorp_ecommerce.zip
```

The archive contained the ecommerce application files.

### File Transfer

The archive was successfully transferred to:

```text
ststor01:/archives/
```

### Remote Verification

The remote file was confirmed using:

```bash
ssh natasha@ststor01 "ls -lh /archives/xfusioncorp_ecommerce.zip"
```

The file was present on the storage server.

---

## Final Configuration

| Requirement                  | Result                          |
| ---------------------------- | ------------------------------- |
| `zip` installed              | ✅                               |
| Archive script created       | ✅                               |
| Script location              | `/scripts/ecommerce_archive.sh` |
| Script executable            | ✅                               |
| Ecommerce directory archived | ✅                               |
| Archive name                 | `xfusioncorp_ecommerce.zip`     |
| Local archive location       | `/archives/`                    |
| Storage server               | `ststor01`                      |
| Remote archive location      | `/archives/`                    |
| Passwordless SCP             | ✅                               |
| Remote archive verified      | ✅                               |
| `sudo` inside script         | ❌ Not used                      |

---

## Key Concepts

### ZIP Archiving

The `zip` utility can recursively package files and directories into a single compressed archive.

The command used was:

```bash
zip -r /archives/xfusioncorp_ecommerce.zip /var/www/html/ecommerce
```

The `-r` option allows the directory and its contents to be archived recursively.

---

### Bash Automation

Instead of manually creating and transferring the archive every time, the process was placed inside a Bash script.

This creates a repeatable workflow:

```text
Ecommerce Files
      ↓
    ZIP
      ↓
Local Archive
      ↓
    SCP
      ↓
Storage Server
```

---

### SCP

`scp` was used to securely copy the archive between servers.

```bash
scp /archives/xfusioncorp_ecommerce.zip natasha@ststor01:/archives/
```

This allows the archive to be transferred over SSH.

---

### Passwordless SSH Authentication

The transfer was performed without embedding a password inside the script.

Instead, SSH key-based authentication allowed SCP to authenticate without requiring interactive password input.

This is important for automation because scripts should not depend on someone manually entering credentials.

---

## DevOps Relevance

This challenge demonstrates several concepts commonly used in DevOps environments:

* Bash scripting
* Linux file management
* Application backup and archiving
* SSH key-based authentication
* Secure file transfer
* Automation of repetitive operational tasks
* Remote server administration

The workflow could be extended in a production environment by scheduling the script with `cron`, storing archives according to a retention policy, adding logging, and integrating the process into a larger backup or deployment pipeline.

---

## Security Considerations

The script does not contain a plaintext password.

Instead, SSH key-based authentication is used for the automated SCP transfer.

Credentials and private SSH keys should never be committed to source control.

The script also avoids using `sudo`, reducing the need for elevated privileges during the archive and transfer process.

---

## What I Learned

From this challenge, I learned how to:

* Install and use the `zip` utility.
* Create Bash scripts for operational automation.
* Recursively archive application files.
* Set executable permissions on scripts.
* Transfer files between Linux servers using SCP.
* Use passwordless SSH authentication for automation.
* Verify files on remote servers.
* Automate repetitive infrastructure and operational tasks.

---

## Commands

The commands used during this challenge are documented in:

[`commands.sh`](./commands.sh)

---

## Challenge Status

**Completed — Day 10/100** ✅
