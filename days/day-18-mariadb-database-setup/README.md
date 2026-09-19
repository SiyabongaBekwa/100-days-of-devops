# Day 18 — MariaDB Database Setup

## Overview

This challenge focused on installing and configuring a MariaDB database server on the Nautilus database server.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

The objective was to:

* Install MariaDB server on the Nautilus database server.
* Create a database named `kodekloud_db2`.
* Create a MariaDB user named `kodekloud_aim`.
* Grant full privileges on `kodekloud_db2` to `kodekloud_aim`.

## Environment

| Component     | Details                       |
| ------------- | ----------------------------- |
| Platform      | KodeKloud                     |
| Environment   | Nautilus / Stratos Datacenter |
| Server        | `stdb01`                      |
| Database      | MariaDB                       |
| Database Name | `kodekloud_db2`               |
| Database User | `kodekloud_aim`               |

## Initial Check

The first check was accidentally performed from the jump host:

```bash
mariadb --version
sudo systemctl status mariadb --no-pager
```

These commands failed because the jump host did not have MariaDB installed and was not running the required systemd environment.

The correct approach was to connect to the Nautilus database server first.

## Implementation

### 1. Connect to the Database Server

```bash
ssh peter@stdb01
```

### 2. Check MariaDB Installation

```bash
mariadb --version
```

MariaDB was not installed, so the command returned:

```text
mariadb: command not found
```

### 3. Install MariaDB Server

```bash
sudo dnf install -y mariadb-server
```

MariaDB Server 10.5.29 was installed successfully.

### 4. Enable and Start MariaDB

```bash
sudo systemctl enable --now mariadb
```

### 5. Verify MariaDB Service

```bash
sudo systemctl status mariadb --no-pager
```

The MariaDB service was verified as active and running.

### 6. Open the MariaDB Console

```bash
sudo mariadb
```

### 7. Create the Database

```sql
CREATE DATABASE kodekloud_db2;
```

### 8. Create the Database User

The actual password used during the challenge is intentionally excluded.

```sql
CREATE USER 'kodekloud_aim'@'localhost' IDENTIFIED BY '<database-password>';
```

### 9. Grant Full Database Permissions

```sql
GRANT ALL PRIVILEGES ON kodekloud_db2.* TO 'kodekloud_aim'@'localhost';
```

### 10. Verify the Database

```sql
SHOW DATABASES LIKE 'kodekloud_db2';
```

### 11. Verify the User

```sql
SELECT User, Host FROM mysql.user WHERE User = 'kodekloud_aim';
```

The user was verified as:

```text
kodekloud_aim | localhost
```

### 12. Verify Permissions

```sql
SHOW GRANTS FOR 'kodekloud_aim'@'localhost';
```

The output confirmed that `kodekloud_aim` had full privileges on:

```text
kodekloud_db2.*
```

### 13. Exit MariaDB

```sql
exit;
```

## Verification

The following configuration was successfully verified:

* MariaDB Server 10.5.29 installed.
* MariaDB service enabled.
* MariaDB service active and running.
* Database `kodekloud_db2` created.
* User `kodekloud_aim@localhost` created.
* Full privileges granted on `kodekloud_db2`.
* KodeKloud challenge completed successfully.

## Key Concepts

### MariaDB

MariaDB is an open-source relational database management system that is commonly used for applications that require structured data storage and SQL-based queries.

### Database Users

MariaDB users control authentication and access to databases and database objects.

In this challenge, the user was restricted to the local host:

```text
'kodekloud_aim'@'localhost'
```

### Database Privileges

Privileges determine what a database user is allowed to do.

The following command grants all privileges on the specific database:

```sql
GRANT ALL PRIVILEGES ON kodekloud_db2.* TO 'kodekloud_aim'@'localhost';
```

### Service Management

The MariaDB service was enabled and started using:

```bash
sudo systemctl enable --now mariadb
```

This ensures the service starts immediately and is enabled to start automatically with the system.

## DevOps Relevance

Database administration is an important part of DevOps because applications commonly depend on database services.

Understanding how to:

* Install database servers
* Manage database services
* Create databases and users
* Configure permissions
* Verify database connectivity and access

provides a foundation for managing application infrastructure and automated deployment environments.

## Security Considerations

The database password used during the challenge is intentionally not stored in this repository.

Passwords, private keys, access tokens, and other secrets should never be committed to Git repositories.

Sensitive values should be replaced with placeholders such as:

```text
<database-password>
```

## Challenge Status

**Completed — Day 18/100** ✅

