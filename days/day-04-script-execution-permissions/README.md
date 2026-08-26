# Day 4: Script Execution Permissions

## Challenge Overview

This challenge focused on managing Linux file permissions and allowing a shell script to be executed by users on the system.

The task required modifying the permissions of an existing script so that it could be executed.

## Objective

The objective was to grant executable permissions to the `/tmp/xfusioncorp.sh` script on the designated application server.

The script initially did not have the required execute permission.

## Implementation

### 1. Connect to the Application Server

The first step was to connect to the designated application server using SSH.

```bash
ssh <user>@<server>
```

> Credentials are intentionally excluded from this repository.

### 2. Check the Existing Script Permissions

The existing permissions of the script were inspected using:

```bash
ls -l /tmp/xfusioncorp.sh
```

The output can be used to determine whether the script currently has execute permissions.

Linux permissions are represented using a permission string such as:

```text
-rw-r--r--
```

The absence of `x` indicates that the file is not executable.

### 3. Grant Execute Permission

Execute permission was granted to the script using:

```bash
chmod a+x /tmp/xfusioncorp.sh
```

The `chmod` command is used to change file permissions.

The options used were:

| Option | Purpose                                    |
| ------ | ------------------------------------------ |
| `a`    | Applies the permission change to all users |
| `+x`   | Adds execute permission                    |

Therefore:

```bash
chmod a+x /tmp/xfusioncorp.sh
```

adds execute permission for the owner, group, and other users.

### 4. Verify the Permissions

The permissions were checked again using:

```bash
ls -l /tmp/xfusioncorp.sh
```

The permission string should now contain `x` for the applicable user categories.

For example:

```text
-rwxr-xr-x
```

The important part is the presence of the execute permission:

```text
x
```

### 5. Verify Script Execution

The script can then be executed using:

```bash
/tmp/xfusioncorp.sh
```

If the script requires a shell interpreter or does not have a valid shebang, it may instead be executed with:

```bash
bash /tmp/xfusioncorp.sh
```

## Verification & Troubleshooting

### Permission Denied

If the script returns:

```text
Permission denied
```

check its permissions:

```bash
ls -l /tmp/xfusioncorp.sh
```

If execute permission is missing, apply:

```bash
chmod a+x /tmp/xfusioncorp.sh
```

### Verify the File Exists

Check that the script exists:

```bash
ls -l /tmp/xfusioncorp.sh
```

### Check File Type

The file type can be inspected using:

```bash
file /tmp/xfusioncorp.sh
```

### Check Current Permissions

The permissions can also be inspected using:

```bash
stat /tmp/xfusioncorp.sh
```

## Key Concepts

### Linux File Permissions

Linux uses file permissions to control what users can do with files and directories.

The three basic permissions are:

* `r` — read
* `w` — write
* `x` — execute

### Permission Categories

Permissions can be assigned to three categories:

* **User/Owner** — the owner of the file
* **Group** — users belonging to the file's group
* **Others** — all other users

For example:

```text
-rwxr-xr-x
```

represents:

```text
Owner:  rwx
Group:  r-x
Others: r-x
```

### chmod

`chmod` is used to modify Linux file permissions.

For example:

```bash
chmod a+x /tmp/xfusioncorp.sh
```

adds execute permission for all users.

### Executable Scripts

A shell script generally needs execute permission when it is intended to be launched directly.

For example:

```bash
./script.sh
```

requires the script to have execute permission.

## DevOps Relevance

File permissions are an important part of Linux administration and DevOps engineering.

Understanding permissions is useful when working with:

* Linux servers
* Application servers
* Deployment scripts
* CI/CD pipelines
* Automation scripts
* Configuration management
* Docker containers
* Cloud virtual machines
* Infrastructure automation

Deployment and automation pipelines frequently execute shell scripts, making correct file permissions important for reliable deployments.

## What I Learned

* How to inspect Linux file permissions
* How Linux read, write, and execute permissions work
* How permissions are assigned to users, groups, and others
* How to use `chmod` to modify file permissions
* How to grant execute permission to a shell script
* How to verify permissions after making a change
* Why file permissions are important in DevOps environments

## Commands

The complete command sequence for this challenge is available in [`commands.sh`](./commands.sh).

## Challenge Status

**Completed — Day 4/100** ✅
