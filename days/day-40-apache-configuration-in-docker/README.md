# Day 40 — Install and Configure Apache Inside a Docker Container

## Overview

This challenge focused on installing and configuring the Apache web server inside an existing Docker container.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Install Apache2 inside the `kkloud` container running on Application Server 2, configure Apache to listen on port `8082`, and ensure that both the Apache service and Docker container remain running.

## Environment

| Component | Details |
|---|---|
| Platform | KodeKloud |
| Environment | Nautilus / Stratos Datacenter |
| Server | Application Server 2 (`stapp02`) |
| User | `steve` |
| Container | `kkloud` |
| Container image | `ubuntu:18.04` |
| Web server | Apache2 |
| Listening port | `8082` |

## Implementation

### 1. Connect to Application Server 2

```bash
ssh steve@stapp02
```

### 2. Verify the container is running

```bash
docker ps
```

The output confirmed that the `kkloud` container was running.

```text
CONTAINER ID   IMAGE          COMMAND       CREATED         STATUS         PORTS     NAMES
bb4e13a9088b   ubuntu:18.04   "/bin/bash"   8 minutes ago   Up 8 minutes             kkloud
```

### 3. Enter the container

```bash
docker exec -it kkloud bash
```

### 4. Install Apache2

Update the package lists and install Apache using APT:

```bash
apt update
apt install apache2 -y
```

### 5. Configure Apache to listen on port 8082

Update the Apache ports configuration:

```bash
sed -i 's/^Listen 80$/Listen 8082/' /etc/apache2/ports.conf
```

Update the default virtual host configuration:

```bash
sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8082>/' /etc/apache2/sites-available/000-default.conf
```

The `Listen 8082` directive allows Apache to listen on the configured port across available network interfaces rather than restricting it to a specific IP address.

### 6. Test the Apache configuration

```bash
apache2ctl configtest
```

Expected output:

```text
Syntax OK
```

An `AH00558` warning about the server's fully qualified domain name was also displayed during verification. The configuration test still returned `Syntax OK`.

### 7. Start and verify Apache

Start the Apache service:

```bash
service apache2 start
```

Check the service status:

```bash
service apache2 status
```

The output confirmed:

```text
apache2 is running
```

### 8. Verify the HTTP response

Test the local HTTP endpoint:

```bash
curl -I http://127.0.0.1:8082
```

The server returned:

```text
HTTP/1.1 200 OK
Server: Apache/2.4.29 (Ubuntu)
Content-Type: text/html
```

This confirmed that Apache was successfully serving HTTP requests on port `8082`.

### 9. Verify the Docker container remains running

Exit the container:

```bash
exit
```

Check the container status on Application Server 2:

```bash
docker ps
```

The output confirmed that `kkloud` remained in the `Up` state.

## Verification

The following results confirmed successful completion:

| Requirement | Result |
|---|---|
| Apache2 installed inside `kkloud` | Successful |
| Apache configured for port `8082` | Successful |
| Apache configuration test | `Syntax OK` |
| Apache service | Running |
| HTTP endpoint | `200 OK` |
| Docker container | Running |

## Key Concepts

### Docker Containers

Docker containers provide isolated environments in which applications and services can run independently of the host system.

### Package Management with APT

APT is the package management tool used on Debian-based Linux distributions, including Ubuntu.

The following commands update package information and install Apache2:

```bash
apt update
apt install apache2 -y
```

### Apache Port Configuration

Apache uses the `Listen` directive to specify the network port on which it accepts incoming connections.

The `ports.conf` file contains the listening-port configuration, while the virtual host configuration defines how Apache handles requests for a particular site.

### Service Management

The `service` command can be used to start and check the status of services inside a Linux environment.

### HTTP Verification

The `curl` command allows administrators to test HTTP endpoints and inspect server response headers.

An HTTP `200 OK` response indicates that the server successfully handled the request.

## DevOps Relevance

Configuring web servers inside containers is an important skill for:

- Containerized application deployments
- Docker-based development environments
- Web server administration
- Application troubleshooting
- CI/CD infrastructure
- Container networking and service management

This challenge also demonstrates how application services can be configured and verified independently inside a container.

## What I Learned

- How to install Apache2 using APT inside a Docker container.
- How to modify Apache listening-port configuration.
- How to configure a virtual host to use a custom port.
- How to validate Apache configuration using `apache2ctl configtest`.
- How to manage and verify Apache services.
- How to test HTTP responses using `curl`.
- How to ensure a Docker container remains running after configuration changes.

## Security and Operational Considerations

- Avoid exposing unnecessary container ports.
- Use appropriate network restrictions when deploying services.
- Keep container images and installed packages updated.
- Validate configuration changes before restarting services.
- Prefer reproducible Dockerfiles for long-term container deployments.

## Challenge Status

**Completed — Day 40/100** ✅

**KodeKloud Result Reference:** `6809e27e83720aedcc71f42f`

