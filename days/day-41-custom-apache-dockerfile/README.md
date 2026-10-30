# Day 41 — Create a Dockerfile to Build a Custom Apache Image

## Overview

This challenge focused on creating a custom Dockerfile to prepare an Apache web server environment using Ubuntu 24.04 as the base image.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Create a Dockerfile at `/opt/docker/Dockerfile` on Application Server 2 that:

- Uses `ubuntu:24.04` as the base image.
- Installs Apache2.
- Configures Apache to listen on port `5000`.
- Exposes port `5000`.
- Runs Apache in the foreground when the container starts.

The challenge required creating and verifying the Dockerfile. Building the image was not required.

## Environment

| Component | Details |
|---|---|
| Platform | KodeKloud |
| Environment | Nautilus / Stratos Datacenter |
| Server | Application Server 2 (`stapp02`) |
| User | `steve` |
| Technology | Docker |
| Base image | `ubuntu:24.04` |
| Web server | Apache2 |
| Listening port | `5000` |
| Dockerfile path | `/opt/docker/Dockerfile` |

## Implementation

### 1. Connect to Application Server 2

```bash
ssh steve@stapp02
```

### 2. Create the Docker directory

```bash
sudo mkdir -p /opt/docker
```

### 3. Create the Dockerfile

```bash
sudo vi /opt/docker/Dockerfile
```

The Dockerfile was configured with the following instructions:

```dockerfile
FROM ubuntu:24.04

RUN apt-get update && apt-get install -y apache2 \
    && sed -i 's/^Listen 80$/Listen 5000/' /etc/apache2/ports.conf \
    && sed -i 's/<VirtualHost \*:80>/<VirtualHost *:5000>/' /etc/apache2/sites-available/000-default.conf \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 5000

CMD ["apachectl", "-D", "FOREGROUND"]
```

### 4. Verify the Dockerfile

```bash
sudo cat /opt/docker/Dockerfile
```

The output confirmed that the Dockerfile was saved at the correct location with the required filename and configuration.

## Dockerfile Explanation

### FROM

```dockerfile
FROM ubuntu:24.04
```

Specifies Ubuntu 24.04 as the base image for the custom environment.

### RUN

```dockerfile
RUN apt-get update && apt-get install -y apache2 \
```

Updates package information and installs Apache2.

The following commands modify Apache's configuration:

```bash
sed -i 's/^Listen 80$/Listen 5000/' /etc/apache2/ports.conf
```

Changes Apache's listening port from 80 to 5000.

```bash
sed -i 's/<VirtualHost \*:80>/<VirtualHost *:5000>/' /etc/apache2/sites-available/000-default.conf
```

Updates the default virtual host to use port 5000 without changing the document root.

Finally:

```bash
rm -rf /var/lib/apt/lists/*
```

Removes cached APT package lists to reduce unnecessary image-layer size.

### EXPOSE

```dockerfile
EXPOSE 5000
```

Documents the port on which the containerized Apache service is intended to listen.

### CMD

```dockerfile
CMD ["apachectl", "-D", "FOREGROUND"]
```

Starts Apache in the foreground when a container is launched from the image. This keeps the main container process running.

## Verification

The Dockerfile was inspected using:

```bash
sudo cat /opt/docker/Dockerfile
```

The following requirements were confirmed:

| Requirement | Result |
|---|---|
| Correct Dockerfile path | `/opt/docker/Dockerfile` |
| Correct filename capitalization | `Dockerfile` |
| Ubuntu base image | `ubuntu:24.04` |
| Apache2 installation | Configured |
| Apache listening port | `5000` |
| Default virtual host port | `5000` |
| Document root | Unchanged |
| Foreground execution | Configured |

**Note:** The challenge required creating the Dockerfile, not building or running the resulting image.

## Key Concepts

### Dockerfiles

A Dockerfile is a text-based set of instructions used to build custom Docker images.

### Image Layers

Docker instructions such as `RUN` create image layers. Combining related installation and configuration commands can reduce unnecessary layers.

### Container Networking

The `EXPOSE` instruction documents the intended container port. It does not automatically publish that port to the host.

### Foreground Processes

Containers generally depend on their main process remaining active. Running Apache in the foreground allows it to serve as the container's main process.

## DevOps Relevance

Creating custom Dockerfiles is an important skill for:

- Containerized application deployments
- Standardized development environments
- CI/CD pipelines
- Custom web server images
- Infrastructure automation
- Reproducible application deployments

## What I Learned

- How to create a Dockerfile from scratch.
- How to select a specific Ubuntu base image.
- How to install Apache using APT.
- How to modify Apache configuration during image creation.
- How to use Dockerfile instructions such as `FROM`, `RUN`, `EXPOSE`, and `CMD`.
- Why foreground execution is important for container lifecycle management.

## Security and Operational Considerations

- Use trusted base images.
- Keep packages updated.
- Avoid including credentials or secrets in Docker image layers.
- Use `.dockerignore` when building images to exclude unnecessary files.
- Prefer reproducible Dockerfile-based builds over manually configured containers.

## Challenge Status

**Completed — Day 41/100** ✅

**KodeKloud Result Reference:** `6809e33583720aedcc71f430`
