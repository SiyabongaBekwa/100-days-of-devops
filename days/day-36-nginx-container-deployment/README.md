# Day 36 — Nginx Container Deployment

## Overview

This challenge focused on deploying an Nginx container using Docker on a Linux application server.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Create a Docker container named `nginx_1` using the `nginx:alpine` image and ensure that the container is running.

## Environment

| Component | Details |
|---|---|
| Platform | KodeKloud |
| Environment | Nautilus / Stratos Datacenter |
| Server | `stapp01` |
| User | `tony` |
| Technology | Docker |
| Container | `nginx_1` |
| Image | `nginx:alpine` |

## Implementation

### 1. Connect to Application Server 1

Connected to the application server from the jump host.

```bash
ssh tony@stapp01
```

### 2. Create and Start the Nginx Container

Ran the following command to pull the image if necessary and start the container in detached mode.

```bash
docker run -d --name nginx_1 nginx:alpine
```

**Command breakdown:**

- `docker run` creates and starts a container.
- `-d` runs the container in the background.
- `--name nginx_1` assigns the required container name.
- `nginx:alpine` specifies the Nginx image with the Alpine tag.

Docker downloaded the image because it was not available locally, then created and started the container successfully.

### 3. Verify the Container

Used the following command to list running containers.

```bash
docker ps
```

The output confirmed that `nginx_1` was running with the `nginx:alpine` image.

**Container ID:** `c4d039e47d40`

**Status:** `Up`

## Key Concepts

### Docker Images and Containers

A Docker image contains the application and the dependencies needed to run it. A container is a running instance of an image.

### Nginx

Nginx is a web server that can also serve as a reverse proxy and load balancer.

### Alpine Image Tag

The Alpine variant of the Nginx image is based on Alpine Linux, a lightweight Linux distribution.

### Detached Mode

The `-d` option runs a container in the background, allowing the terminal to remain available for other commands.

### Container Verification

The `docker ps` command lists running containers. The `docker ps -a` command lists all containers, including stopped ones.

## DevOps Relevance

Container deployment is a foundational DevOps skill. Docker containers help teams package and run applications consistently across development, testing, and deployment environments.

This knowledge supports further learning in containerized CI/CD pipelines, Docker Compose, Kubernetes, and cloud platforms.

## What I Learned

- How to connect to a remote Linux application server using SSH
- How to deploy a container from a Docker image
- How to assign a specific container name
- How to run a container in detached mode
- How to verify that a container is running

## Security and Operational Considerations

- Use trusted container images and keep them updated.
- Publish container ports only when required.
- Check container logs and status when troubleshooting.
- Avoid running containers with unnecessary privileges.

## Challenge Status

**Completed — Day 36/100** ✅

**Container:** `nginx_1`

**Image:** `nginx:alpine`

**KodeKloud Result Reference:** `6809de5183720aedcc71f429`
