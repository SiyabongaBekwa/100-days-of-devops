# Day 19 — Apache Static Website Deployment

## Overview

This challenge focused on installing and configuring Apache HTTP Server to host two static websites on an application server.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Configure Apache on application server 2 so that it:

* Has the required `httpd` package and dependencies installed.
* Listens on port `8089`.
* Serves the `news` website.
* Serves the `cluster` website.
* Allows both websites to be verified using `curl`.

The website backups were located on the jump host under:

```text
/home/thor/news
/home/thor/cluster
```

The completed websites were accessible through:

```text
http://localhost:8089/news/
http://localhost:8089/cluster/
```

## Environment

| Component   | Details                       |
| ----------- | ----------------------------- |
| Platform    | KodeKloud                     |
| Environment | Nautilus / Stratos Datacenter |
| Server      | `stapp02`                     |
| User        | `steve`                       |
| Web Server  | Apache HTTP Server (`httpd`)  |
| Port        | `8089`                        |
| Websites    | `news`, `cluster`             |
| Web Root    | `/var/www/html`               |

## Implementation

### 1. Connect to the Application Server

The task was performed on application server 2.

```bash
ssh steve@stapp02
```

### 2. Install Apache

The Apache HTTP Server package and required dependencies were installed using `dnf`.

```bash
sudo dnf install -y httpd
```

### 3. Configure Apache to Use Port 8089

The default Apache listening port was changed from port `80` to port `8089`.

```bash
sudo sed -i 's/^Listen 80$/Listen 8089/' /etc/httpd/conf/httpd.conf
```

The configuration was then checked:

```bash
grep '^Listen' /etc/httpd/conf/httpd.conf
```

Expected output:

```text
Listen 8089
```

### 4. Validate the Apache Configuration

Before starting Apache, the configuration syntax was checked:

```bash
sudo apachectl configtest
```

The command returned:

```text
Syntax OK
```

Apache also displayed a warning about not being able to reliably determine the server's fully qualified domain name. The configuration test still completed successfully.

### 5. Enable and Start Apache

Apache was enabled to start automatically and started immediately:

```bash
sudo systemctl enable --now httpd
```

The service status was checked:

```bash
sudo systemctl status httpd --no-pager
```

The service was confirmed to be running and configured to listen on port `8089`.

### 6. Copy the Website Backups

The website directories were copied from the jump host to the application server's `/tmp` directory.

```bash
scp -r thor@jump-host:/home/thor/news /tmp/
```

```bash
scp -r thor@jump-host:/home/thor/cluster /tmp/
```

Authentication was required during the transfer. Credentials are intentionally excluded from this documentation.

### 7. Deploy the Websites

The copied website directories were moved into Apache's web root:

```bash
sudo cp -r /tmp/news /var/www/html/
```

```bash
sudo cp -r /tmp/cluster /var/www/html/
```

The website files were then checked:

```bash
ls -l /var/www/html/news/
```

```bash
ls -l /var/www/html/cluster/
```

Both directories contained an `index.html` file.

## Verification

### News Website

The `news` website was tested using:

```bash
curl http://localhost:8089/news/
```

The response contained:

```html
<h1>KodeKloud</h1>
<p>This is a sample page for our news website</p>
```

### Cluster Website

The `cluster` website was tested using:

```bash
curl http://localhost:8089/cluster/
```

The response contained:

```html
<h1>KodeKloud</h1>
<p>This is a sample page for our cluster website</p>
```

Both websites were successfully served by Apache on port `8089`.

## Key Concepts

### Apache HTTP Server

Apache HTTP Server is a web server used to serve web content over HTTP.

In this challenge, Apache was configured to serve static HTML websites.

### Apache Listening Ports

Apache can be configured to listen on a specific TCP port using the `Listen` directive.

For this challenge:

```text
Listen 8089
```

### Apache Document Root

The Apache web root used in this challenge was:

```text
/var/www/html
```

The website directories were placed inside this directory:

```text
/var/www/html/news
/var/www/html/cluster
```

This allowed them to be accessed through their respective URL paths.

### SCP

`scp` was used to securely copy the website directories from the jump host to the application server.

```bash
scp -r thor@jump-host:/home/thor/news /tmp/
```

### Curl

`curl` was used to verify that Apache was successfully serving the websites:

```bash
curl http://localhost:8089/news/
```

```bash
curl http://localhost:8089/cluster/
```

## DevOps Relevance

This challenge demonstrates several practical DevOps skills:

* Installing Linux packages
* Configuring web servers
* Managing systemd services
* Changing application configuration
* Moving files between servers
* Deploying static web content
* Testing services from the command line
* Troubleshooting web server configuration

These are foundational skills for managing application servers and deploying workloads in Linux-based infrastructure.

## Security Considerations

No passwords, private keys, tokens, or other credentials are stored in this repository.

Authentication details used during the lab have intentionally been excluded.

When documenting infrastructure commands, sensitive values should be replaced with placeholders rather than committed to source control.

## Challenge Status

**Completed — Day 19/100** ✅

