# Day 9 — MariaDB Service Troubleshooting

## Challenge

The Nautilus development team reported that the MariaDB service was not starting correctly on the database server.

The task was to troubleshoot the MariaDB service, identify the configuration issue, correct it, and start the service successfully.

## Objective

The objective of this challenge was to:

* Troubleshoot a failed MariaDB service.
* Identify the ownership problem with the MariaDB data directory.
* Correct the ownership of `/var/lib/mysql`.
* Start the MariaDB service.
* Verify that the service is running successfully.
* Use `systemctl` to manage and verify Linux services.

## Environment

| Component          | Configuration     |
| ------------------ | ----------------- |
| Server             | `stdb01`          |
| User               | `peter`           |
| Database           | MariaDB           |
| MariaDB Version    | `10.5`            |
| Database Directory | `/var/lib/mysql`  |
| Required Owner     | `mysql:mysql`     |
| Service            | `mariadb.service` |
| Service Manager    | `systemd`         |

---

## Implementation

### 1. Identify the MariaDB Data Directory

The MariaDB data directory is located at:

```bash
/var/lib/mysql
```

The directory ownership was incorrect. It was owned by `root:mysql` instead of the required `mysql:mysql`.

MariaDB requires the database files and directory to be accessible by the `mysql` service account.

---

### 2. Correct the Directory Ownership

The ownership of the MariaDB data directory was changed to the `mysql` user and group.

```bash
sudo chown mysql:mysql /var/lib/mysql
```

This changes:

* Owner → `mysql`
* Group → `mysql`

---

### 3. Verify the Directory Ownership

The directory ownership can be verified using:

```bash
ls -ld /var/lib/mysql
```

The expected ownership should show `mysql mysql`.

---

### 4. Start the MariaDB Service

After correcting the directory ownership, the MariaDB service was started using `systemctl`.

```bash
sudo systemctl start mariadb
```

No errors were returned, indicating that the service started successfully.

---

### 5. Check the MariaDB Service Status

The service status was then checked to confirm that MariaDB was running.

```bash
sudo systemctl status mariadb --no-pager
```

The service reported:

```text
Active: active (running)
```

The MariaDB process also reported:

```text
Status: "Taking your SQL requests now..."
```

This confirmed that the database service was operational.

---

### 6. Verify the Service State

The final service state was verified using:

```bash
sudo systemctl is-active mariadb
```

The command returned:

```text
active
```

This confirmed that MariaDB was successfully running.

---

## Verification

The troubleshooting process was verified by checking the MariaDB service state.

### Service Status

```bash
sudo systemctl status mariadb --no-pager
```

Result:

```text
Active: active (running)
```

### Service State

```bash
sudo systemctl is-active mariadb
```

Result:

```text
active
```

The MariaDB service was therefore successfully restored.

---

## Final Configuration

| Check                  | Result             |
| ---------------------- | ------------------ |
| MariaDB data directory | `/var/lib/mysql`   |
| Directory owner        | `mysql`            |
| Directory group        | `mysql`            |
| MariaDB service        | `mariadb.service`  |
| Service state          | `active (running)` |
| Database availability  | Operational        |

---

## Key Concepts

### Linux File Ownership

Linux files and directories have an owner and a group.

The MariaDB data directory must be owned by the account used by the MariaDB service.

The required ownership was:

```text
mysql:mysql
```

The format is:

```text
owner:group
```

---

### `chown`

The `chown` command changes file and directory ownership.

The command used in this challenge was:

```bash
sudo chown mysql:mysql /var/lib/mysql
```

This changed both the owner and group of the MariaDB data directory.

---

### systemd

`systemd` is the service and system manager used by the Linux environment.

The `systemctl` command was used to manage MariaDB.

For example:

```bash
sudo systemctl start mariadb
```

starts the service.

The following command checks the service status:

```bash
sudo systemctl status mariadb --no-pager
```

And:

```bash
sudo systemctl is-active mariadb
```

returns the current service state.

---

## DevOps Relevance

Database services are critical components of production environments.

A DevOps engineer needs to be able to:

* Diagnose service failures.
* Understand Linux file permissions and ownership.
* Manage services using `systemd`.
* Read service status information.
* Correct configuration and permission problems.
* Verify that services are operational after making changes.

This challenge demonstrates a basic but important operational troubleshooting workflow:

```text
Identify problem
       ↓
Inspect configuration
       ↓
Correct ownership
       ↓
Start service
       ↓
Verify service status
```

These troubleshooting skills are applicable to Linux servers, cloud virtual machines, application servers, and database infrastructure.

---

## Security Considerations

The MariaDB data directory should only be accessible to the appropriate service account.

Using:

```bash
sudo chown mysql:mysql /var/lib/mysql
```

ensures that MariaDB owns its database directory rather than using an overly privileged account such as `root`.

Avoid unnecessarily changing permissions to overly permissive values such as:

```text
777
```

because this can expose sensitive database files to other users on the system.

The principle of least privilege should be maintained when managing database infrastructure.

---

## What I Learned

From this challenge, I learned how to:

* Troubleshoot a MariaDB service failure.
* Identify incorrect Linux directory ownership.
* Correct ownership using `chown`.
* Start services using `systemctl`.
* Inspect service status.
* Verify service availability using `systemctl is-active`.
* Understand the importance of correct service-account permissions.
* Apply Linux troubleshooting techniques to database infrastructure.

---

## Commands

The commands used during this challenge are documented in:

[`commands.sh`](./commands.sh)

---

## Challenge Status

**Completed — Day 9/100** ✅
