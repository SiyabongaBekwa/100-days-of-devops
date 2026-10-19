# Day 35 — Install Docker CE and Docker Compose

## Overview

This challenge focused on installing Docker Community Edition (Docker CE), installing Docker Compose, and starting the Docker service on a Linux server.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

1. Install Docker CE on App Server 3.
2. Install Docker Compose.
3. Start the Docker service.
4. Enable Docker to start automatically after a system reboot.
5. Verify the service status and installed versions.

## Environment

| Component | Details |
|---|---|
| Platform | KodeKloud |
| Environment | Nautilus / Stratos Datacenter |
| Server | `stapp03` |
| User | `banner` |
| Operating System | CentOS Stream 9 |
| Technology | Docker CE and Docker Compose |
| Service | `docker.service` |

## Implementation

### 1. Connect to App Server 3

Connected to the application server and verified its hostname and operating system.

```bash
ssh banner@stapp03
hostname
cat /etc/os-release
```

The server was confirmed as `stapp03`, running CentOS Stream 9.

### 2. Inspect Configured Package Repositories

Checked the available DNF repositories before installing Docker.

```bash
sudo dnf repolist
```

Docker's official repository was not initially configured.

### 3. Configure Docker's Official Repository

Added the official Docker repository for CentOS.

```bash
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

### 4. Install Docker CE and Docker Compose

Installed Docker CE, the Docker CLI, containerd, the Buildx plugin, and the Docker Compose plugin.

```bash
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

The package installation completed successfully.

### 5. Start and Enable Docker

Started the Docker service and enabled it to start automatically at boot.

```bash
sudo systemctl enable --now docker
```

### 6. Verify the Installation

Checked the Docker service status and installed versions.

```bash
sudo systemctl status docker --no-pager
docker --version
docker compose version
```

The service status confirmed that Docker was active and running.

**Verified versions:**

- Docker: `29.9.1`
- Docker Compose: `v5.6.0`

## Key Concepts

### Docker CE

Docker Community Edition provides the tools required to build, distribute, and run applications in containers.

### Docker Compose

Docker Compose allows developers and operations teams to define and manage multi-container applications using configuration files.

### Linux Service Management

`systemctl` is used to manage services on systems running systemd.

The command `sudo systemctl enable --now docker` both starts the service immediately and enables it to start automatically during boot.

### Package Management with DNF

DNF manages software packages and repositories on CentOS Stream and other compatible Linux distributions.

## DevOps Relevance

Containerization is an important part of modern DevOps workflows. Docker supports consistent application environments and integrates with CI/CD pipelines, cloud platforms, and container orchestration tools such as Kubernetes.

## What I Learned

- How to identify a Linux distribution before installing software
- How to inspect configured DNF repositories
- How to add Docker's official package repository
- How to install Docker CE and Docker Compose
- How to start and enable a Linux service
- How to verify service health and software versions

## Security and Operational Considerations

- Install packages from trusted repositories.
- Apply appropriate access controls to the Docker daemon.
- Review service status and logs when troubleshooting.
- Keep Docker and related components updated according to operational requirements.

## Challenge Status

**Completed — Day 35/100** ✅

**KodeKloud Result Reference:** `68078bca399a2462b6cc6687`
