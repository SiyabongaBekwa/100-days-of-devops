# Day 20 — Nginx + PHP-FPM Deployment

## Overview

This challenge focused on deploying a PHP application using **Nginx** and **PHP-FPM** in the Nautilus infrastructure environment.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge.

The application was deployed on `stapp01` and configured to run on port `8091`.

## Objective

Configure the application server to:

* Install Nginx.
* Configure Nginx to listen on port `8091`.
* Use `/var/www/html` as the document root.
* Install PHP 8.1 and PHP-FPM.
* Configure PHP-FPM to use the Unix socket `/var/run/php-fpm/default.sock`.
* Configure Nginx to process PHP requests through PHP-FPM.
* Verify the PHP application using `curl`.

The task requirements specified that the existing `index.php` and `info.php` files should not be modified.

## Environment

| Component          | Details                         |
| ------------------ | ------------------------------- |
| Platform           | KodeKloud                       |
| Environment        | Nautilus / Stratos Datacenter   |
| Application Server | `stapp01`                       |
| SSH User           | `tony`                          |
| Web Server         | Nginx                           |
| Nginx Port         | `8091`                          |
| Document Root      | `/var/www/html`                 |
| PHP Version        | 8.1.27                          |
| PHP-FPM Socket     | `/var/run/php-fpm/default.sock` |
| PHP-FPM            | PHP-FPM                         |
| Test Endpoint      | `http://stapp01:8091/index.php` |

## Implementation

### 1. Connect to the Application Server

Connected to the first application server:

```bash
ssh tony@stapp01
```

### 2. Install Nginx

Installed Nginx using DNF:

```bash
sudo dnf install -y nginx
```

The installed Nginx version was `1.20.1`.

### 3. Configure Nginx Port

Changed the Nginx IPv4 listener from port `80` to `8091`:

```bash
sudo sed -i 's/listen       80;/listen       8091;/' /etc/nginx/nginx.conf
```

The IPv6 listener was also changed:

```bash
sudo sed -i 's/listen       \[::\]:80;/listen       [::]:8091;/' /etc/nginx/nginx.conf
```

Configuration was verified with:

```bash
grep -n "listen" /etc/nginx/nginx.conf
```

### 4. Validate Nginx Configuration

Before starting Nginx, the configuration was tested:

```bash
sudo nginx -t
```

The configuration test completed successfully.

### 5. Enable PHP 8.1

Checked the available PHP modules:

```bash
sudo dnf module list php
```

Enabled PHP 8.1:

```bash
sudo dnf module enable -y php:8.1
```

Installed PHP and PHP-FPM:

```bash
sudo dnf install -y php php-fpm
```

PHP 8.1.27 was installed.

### 6. Configure the PHP-FPM Socket

Created the required parent directory:

```bash
sudo mkdir -p /var/run/php-fpm
```

The PHP-FPM configuration was located at:

```text
/etc/php-fpm.d/www.conf
```

Changed the PHP-FPM socket from the default socket to:

```text
/var/run/php-fpm/default.sock
```

Command used:

```bash
sudo sed -i 's|^listen = .*|listen = /var/run/php-fpm/default.sock|' /etc/php-fpm.d/www.conf
```

Configured the socket settings:

```bash
sudo sed -i \
  -e 's|^;listen.owner =.*|listen.owner = nginx|' \
  -e 's|^;listen.group =.*|listen.group = nginx|' \
  -e 's|^;listen.mode =.*|listen.mode = 0660|' \
  /etc/php-fpm.d/www.conf
```

The PHP-FPM service later reported that the explicit `listen.owner` and `listen.group` settings were ignored because ACLs were already configured for the socket.

### 7. Configure the Nginx Document Root

The default Nginx document root was:

```text
/usr/share/nginx/html
```

It was changed to:

```text
/var/www/html
```

Command used:

```bash
sudo sed -i 's|root         /usr/share/nginx/html;|root         /var/www/html;|' /etc/nginx/nginx.conf
```

### 8. Configure PHP Processing

Nginx was configured to send PHP requests to PHP-FPM through the Unix socket:

```nginx
location ~ \.php$ {
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_pass unix:/var/run/php-fpm/default.sock;
}
```

The `SCRIPT_FILENAME` parameter ensures that PHP-FPM receives the correct PHP script path.

## Troubleshooting

During configuration, the first PHP location block was inserted into an invalid section of `nginx.conf`.

Running:

```bash
sudo nginx -t
```

returned an error indicating:

```text
"location" directive is not allowed here
```

The incorrectly positioned block was removed and the configuration file was inspected using:

```bash
sudo nl -ba /etc/nginx/nginx.conf | sed -n '35,90p'
```

The configuration was then corrected.

### PHP-FPM Socket Conflict

After the main configuration appeared correct, PHP requests were still returning `404`.

The Nginx error log was checked:

```bash
sudo tail -20 /var/log/nginx/error.log
```

The log showed that Nginx was still attempting to use the old PHP-FPM socket:

```text
/run/php-fpm/www.sock
```

The old socket reference was located with:

```bash
sudo grep -R "www.sock" /etc/nginx/
```

A conflicting configuration was found in:

```text
/etc/nginx/conf.d/php-fpm.conf
```

The file contained an upstream configuration referencing the old PHP-FPM socket.

It was removed:

```bash
sudo rm /etc/nginx/conf.d/php-fpm.conf
```

After another Nginx configuration test, another default PHP configuration was found:

```text
/etc/nginx/default.d/php.conf
```

This configuration also referenced the old `php-fpm` upstream.

It was removed:

```bash
sudo rm /etc/nginx/default.d/php.conf
```

The final Nginx configuration test succeeded:

```bash
sudo nginx -t
```

## Start Services

PHP-FPM was enabled and started:

```bash
sudo systemctl enable --now php-fpm
```

Nginx was enabled and started:

```bash
sudo systemctl enable --now nginx
```

The PHP-FPM socket was verified:

```bash
sudo ls -l /var/run/php-fpm/default.sock
```

## Verification

After removing the conflicting PHP-FPM configurations, Nginx was reloaded:

```bash
sudo systemctl reload nginx
```

The application was tested locally:

```bash
curl http://localhost:8091/index.php
```

The expected response was returned:

```text
Welcome to xFusionCorp Industries!
```

The final challenge verification was performed from the jump host:

```bash
curl http://stapp01:8091/index.php
```

The application successfully returned:

```text
Welcome to xFusionCorp Industries!
```

The KodeKloud challenge was successfully completed.

## Key Concepts

### Nginx

Nginx is a web server and reverse proxy commonly used to serve static content and route dynamic application requests.

In this challenge, Nginx handled HTTP requests on port `8091`.

### PHP-FPM

PHP-FPM (FastCGI Process Manager) provides a way for Nginx to execute PHP applications.

Nginx forwards PHP requests to PHP-FPM through a Unix socket.

### Unix Sockets

Instead of communicating over a TCP port, Nginx and PHP-FPM were configured to communicate through:

```text
/var/run/php-fpm/default.sock
```

### FastCGI

FastCGI provides the interface between Nginx and PHP-FPM.

The Nginx configuration used:

```nginx
fastcgi_pass unix:/var/run/php-fpm/default.sock;
```

### Configuration Troubleshooting

A major part of this challenge involved identifying configuration conflicts.

The final issue was not the main Nginx server block but additional configuration files that continued to reference the old PHP-FPM socket.

This demonstrated the importance of checking the complete active configuration instead of only inspecting the main configuration file.

## DevOps Relevance

This challenge provided practical experience with:

* Linux package management
* Nginx configuration
* PHP-FPM
* Unix sockets
* FastCGI
* Linux systemd services
* Application deployment
* Configuration troubleshooting
* Service verification
* HTTP testing with `curl`

These are useful skills when working with Linux-based application servers and web application infrastructure.

## What I Learned

* How to install and configure Nginx.
* How to change an Nginx listening port.
* How to configure a custom document root.
* How to install PHP 8.1 and PHP-FPM.
* How Nginx communicates with PHP-FPM.
* How Unix sockets can be used for application communication.
* How to troubleshoot conflicting Nginx configuration files.
* How to use Nginx logs to identify configuration problems.
* How to verify an application from both the local server and jump host.

## Security Considerations

No passwords, private keys, access tokens, or other credentials are stored in this repository.

Sensitive information should always be replaced with placeholders when documenting infrastructure work.

## Challenge Status

**Completed — Day 20/100** ✅

**KodeKloud Ref ID:** `68077509399a2462b6cc6671`


