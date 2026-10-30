# Day 43 — Deploy an Nginx Container with Port Mapping

## Overview

This challenge focused on deploying an Nginx-based Docker container and exposing its web service through a custom host port.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Pull the `nginx:alpine-perl` Docker image and create a running container named `blog` on Application Server 1.

The container must expose its internal HTTP port 80 through host port 8089.

## Environment

| Component | Details |
|---|---|
| Platform | KodeKloud |
| Environment | Nautilus / Stratos Datacenter |
| Server | App Server 1 (`stapp01`) |
| User | `tony` |
| Technology | Docker |
| Image | `nginx:alpine-perl` |
| Container | `blog` |
| Port mapping | `8089:80` |

## Implementation

### 1. Connect to Application Server 1

```bash
ssh tony@stapp01
```

### 2. Pull the Nginx Image

```bash
docker pull nginx:alpine-perl
```

The image was downloaded successfully from Docker Hub.

### 3. Create and Start the Container

```bash
docker run -d --name blog -p 8089:80 nginx:alpine-perl
```

Command breakdown:

- `-d`: Runs the container in detached mode.
- `--name blog`: Assigns the name `blog` to the container.
- `-p 8089:80`: Maps host port 8089 to container port 80.
- `nginx:alpine-perl`: Specifies the Docker image.

## Verification

### 1. Check Container Status

```bash
docker ps
```

The output confirmed that the `blog` container was running.

The reported port mapping was:

```text
0.0.0.0:8089->80/tcp
```

### 2. Test the Nginx Web Service

```bash
curl -I http://localhost:8089
```

The server returned:

```text
HTTP/1.1 200 OK
Server: nginx/1.31.8
```

This confirmed that Nginx was responding successfully through the mapped host port.

## Key Concepts

### Docker Images

A Docker image contains the application and its required dependencies. The `nginx:alpine-perl` image provides the Nginx web server.

### Docker Containers

A container is a running instance of a Docker image. The deployed container was named `blog`.

### Port Mapping

Port mapping makes a service running inside a container accessible through a port on the Docker host.

In this challenge:

- Host port: `8089`
- Container port: `80`

### Detached Mode

The `-d` option allows a container to run in the background without occupying the terminal session.

### Service Verification

The `docker ps` and `curl` commands were used to confirm that the container was running and the Nginx service was responding.

## DevOps Relevance

Container deployment and port mapping are essential skills for:

- Hosting web applications.
- Deploying containerised services.
- Configuring application access.
- Managing Docker environments.
- Building container-based infrastructure.
- Supporting CI/CD deployment workflows.

## What I Learned

- How to pull Docker images from Docker Hub.
- How to create and run named containers.
- How to configure Docker port mapping.
- How to run containers in detached mode.
- How to verify container health and HTTP responses.

## Challenge Status

**Completed — Day 43/100** ✅

**KodeKloud Result Reference:** `6809e43183720aedcc71f432`
