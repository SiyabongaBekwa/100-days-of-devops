# Day 17 — PostgreSQL Database Setup

## Overview

This challenge focused on setting up a PostgreSQL database and database user for a newly developed application in the Nautilus infrastructure environment.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge.

## Objective

Prepare the existing PostgreSQL server according to the application team's requirements:

* Create a PostgreSQL database user named `kodekloud_gem`
* Configure the user's password
* Create a database named `kodekloud_db7`
* Grant full permissions on the database to `kodekloud_gem`
* Do not restart the PostgreSQL service

## Environment

| Component     | Details                       |
| ------------- | ----------------------------- |
| Platform      | KodeKloud                     |
| Environment   | Nautilus / Stratos Datacenter |
| Server        | `stdb01`                      |
| Database      | PostgreSQL                    |
| Database User | `kodekloud_gem`               |
| Database      | `kodekloud_db7`               |

## Implementation

The PostgreSQL server was already installed on the Nautilus database server.

The PostgreSQL service was checked to confirm that it was running before making any database changes.

The implementation consisted of:

1. Connecting to the PostgreSQL database server.
2. Verifying the PostgreSQL service status.
3. Opening the PostgreSQL command-line interface as the `postgres` user.
4. Creating the required database user.
5. Creating the required database.
6. Granting full database privileges to the application user.
7. Verifying the database and user configuration.
8. Exiting PostgreSQL without restarting the service.

## Commands

### Connect to the Database Server

```bash
ssh peter@stdb01
```

### Verify PostgreSQL Service

```bash
sudo systemctl status postgresql --no-pager
```

The service was confirmed to be **active (running)**.

> The PostgreSQL service was not restarted because the challenge explicitly instructed not to restart it.

### Open PostgreSQL

```bash
sudo -u postgres psql
```

### Create the Database User

The actual password used during the lab is intentionally excluded from this repository.

```sql
CREATE USER kodekloud_gem WITH PASSWORD '<database-password>';
```

### Create the Database

```sql
CREATE DATABASE kodekloud_db7;
```

### Grant Database Permissions

```sql
GRANT ALL PRIVILEGES ON DATABASE kodekloud_db7 TO kodekloud_gem;
```

### Verify the Database

```sql
\l kodekloud_db7
```

### Verify the User

```sql
\du kodekloud_gem
```

### Exit PostgreSQL

```sql
\q
```

## Verification

The database verification showed that:

```text
kodekloud_db7
```

was successfully created.

The database access privileges included:

```text
kodekloud_gem=CTc/postgres
```

The role verification confirmed that:

```text
kodekloud_gem
```

exists as a PostgreSQL role.

The PostgreSQL service remained running throughout the task.

## Key Concepts

### PostgreSQL Roles

PostgreSQL uses roles to manage database access. A role can be used as a database user for applications and other services.

### Database Permissions

Database privileges control what a PostgreSQL role is allowed to do within a database.

In this challenge, `kodekloud_gem` was granted all privileges on `kodekloud_db7`.

### Service Management

Before modifying a database environment, checking the service status helps confirm that the database server is available.

The challenge specifically required that PostgreSQL not be restarted.

## DevOps Relevance

Database administration is an important part of DevOps and infrastructure engineering.

DevOps engineers may be responsible for:

* Provisioning database environments
* Managing database users and permissions
* Supporting application deployments
* Troubleshooting database connectivity
* Automating database configuration
* Applying least-privilege access controls
* Maintaining reliable application infrastructure

Understanding PostgreSQL administration also provides useful knowledge when working with cloud database services and infrastructure-as-code.

## Security Considerations

The PostgreSQL password used during the lab is **not stored in this repository**.

Secrets such as:

* Passwords
* API keys
* Access tokens
* Private keys
* Database credentials

should never be committed to a public Git repository.

Sensitive values are represented using placeholders such as:

```text
<database-password>
```

## Challenge Result

The KodeKloud challenge was successfully completed and accepted.

**Status: Completed — Day 17/100** ✅


