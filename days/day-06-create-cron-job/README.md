# Day 6 — Create a Cron Job

## Objective

The objective of this challenge was to install the required cron package, start the cron service, and configure a scheduled job for the root user.

The cron job was configured to run every five minutes and write the message `hello` to `/tmp/cron_text`.

This task provided practical experience with Linux package management, system services, scheduled tasks, and automation.

> **Security Note:** Credentials used to access the KodeKloud lab are intentionally excluded from this repository.

## Environment

* **Platform:** KodeKloud
* **Infrastructure:** Nautilus / Stratos Datacenter
* **Servers:** Application Servers
* **Operating System:** Linux
* **Service:** `crond`
* **Scheduler:** Cron

## Implementation

### 1. Connect to the Application Server

The first step was to connect to the designated application server using SSH.

```bash
ssh <user>@<server>
```

> Replace `<user>` and `<server>` with the server details provided by the lab.

### 2. Install the Cron Package

The required `cronie` package was installed on the application server.

```bash
sudo yum install -y cronie
```

The `-y` option automatically confirms the package installation.

### 3. Start the Cron Service

The cron daemon was started using:

```bash
sudo systemctl start crond
```

### 4. Verify the Cron Service

The status of the cron service was checked using:

```bash
sudo systemctl status crond
```

The service should show that it is running.

The service can also be checked with:

```bash
sudo systemctl is-active crond
```

Expected output:

```text
active
```

### 5. Configure the Cron Job

The cron job was added for the root user.

The root user's crontab was opened using:

```bash
sudo crontab -e
```

The following entry was added:

```text
*/5 * * * * echo hello > /tmp/cron_text
```

This configures the command to execute every five minutes.

The cron schedule consists of:

| Field        | Value | Meaning               |
| ------------ | ----- | --------------------- |
| Minute       | `*/5` | Every five minutes    |
| Hour         | `*`   | Every hour            |
| Day of Month | `*`   | Every day             |
| Month        | `*`   | Every month           |
| Day of Week  | `*`   | Every day of the week |

### 6. Verify the Cron Job

The root user's cron configuration was verified using:

```bash
sudo crontab -l
```

The expected entry is:

```text
*/5 * * * * echo hello > /tmp/cron_text
```

### 7. Verify the Output File

After the cron job has executed, the output file can be checked using:

```bash
cat /tmp/cron_text
```

Expected output:

```text
hello
```

## Verification & Troubleshooting

### Check the Cron Service

Use:

```bash
sudo systemctl status crond
```

A simpler check is:

```bash
sudo systemctl is-active crond
```

Expected output:

```text
active
```

### Check the Cron Job

Display the root user's cron jobs:

```bash
sudo crontab -l
```

Verify that the following entry exists:

```text
*/5 * * * * echo hello > /tmp/cron_text
```

### Check the Output File

Use:

```bash
cat /tmp/cron_text
```

Expected output:

```text
hello
```

### Check Whether the Cron Package Is Installed

Use:

```bash
rpm -qa | grep cronie
```

This can be used to confirm that the `cronie` package is installed.

### Common Issues

#### Cron Service Is Not Running

Start the service:

```bash
sudo systemctl start crond
```

Then verify:

```bash
sudo systemctl is-active crond
```

#### Cron Job Is Missing

Display the root user's crontab:

```bash
sudo crontab -l
```

If the job is not present, open the crontab:

```bash
sudo crontab -e
```

Then add:

```text
*/5 * * * * echo hello > /tmp/cron_text
```

#### Output File Does Not Exist

Cron runs according to its schedule. Because the job runs every five minutes, the output file may not exist immediately after creating the cron entry.

After the scheduled interval, check:

```bash
cat /tmp/cron_text
```

## Key Concepts

### Cron

Cron is a Linux scheduling mechanism used to execute commands or scripts automatically at specified times or intervals.

It is commonly used for recurring administrative and automation tasks.

### Cron Daemon

The `crond` service runs in the background and is responsible for executing scheduled cron jobs.

The service can be managed using `systemctl`.

### Crontab

A crontab contains scheduled tasks for a Linux user.

The root user's cron jobs can be viewed with:

```bash
sudo crontab -l
```

### Cron Schedule

The cron expression:

```text
*/5 * * * *
```

means that the command should execute every five minutes.

### Output Redirection

The command:

```bash
echo hello > /tmp/cron_text
```

uses `>` to redirect the command output into `/tmp/cron_text`.

The file is overwritten each time the cron job runs.

## DevOps Relevance

Cron jobs are relevant to DevOps because scheduled automation is commonly used for:

* System maintenance
* Log management
* Database backups
* Cleanup tasks
* Monitoring scripts
* Report generation
* Scheduled automation
* Infrastructure administration

Understanding cron provides a foundation for more advanced automation and scheduling systems used in DevOps environments.

Cron concepts are useful when working with:

* Linux servers
* Cloud virtual machines
* CI/CD infrastructure
* Application servers
* Automation systems
* Configuration-management tools

## What I Learned

* How to install the `cronie` package
* How to start the `crond` service
* How to verify Linux services using `systemctl`
* How to create a cron job
* How cron scheduling expressions work
* How to configure a cron job for the root user
* How to verify scheduled jobs using `crontab`
* How to redirect command output to a file
* The importance of verifying scheduled automation

## Commands

The complete command sequence for this challenge is available in [`commands.sh`](./commands.sh).

## Challenge Status

**Completed — Day 6/100** ✅
