# Day 39 — Create and Commit Docker Image From Container

## Overview

This challenge focused on creating a new Docker image from an existing running container using the `docker commit` command.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Create a Docker image named `official:datacenter` from the running container `ubuntu_latest` on Application Server 1.

The purpose was to preserve the current filesystem state and changes made inside the container as a reusable Docker image.

## Environment

| Component | Details |
|---|---|
| Platform | KodeKloud |
| Environment | Nautilus / Stratos Datacenter |
| Server | Application Server 1 (`stapp01`) |
| User | `tony` |
| Technology | Docker |
| Source container | `ubuntu_latest` |
| New image | `official:datacenter` |

## Implementation

### 1. Connect to Application Server 1

```bash
ssh tony@stapp01
```

### 2. Verify the running container

```bash
docker ps
```

The output confirmed that `ubuntu_latest` was running.

```text
CONTAINER ID   IMAGE     COMMAND       CREATED         STATUS         PORTS     NAMES
086c3c34f9a0   ubuntu    "/bin/bash"   2 minutes ago   Up 2 minutes             ubuntu_latest
```

### 3. Create the Docker image

The `docker commit` command was used to create a new image from the existing container.

```bash
docker commit ubuntu_latest official:datacenter
```

The command completed successfully and returned:

```text
sha256:31fb51f95c4aa4568b703802efeba7fd21973092b2c4c88c8472031e9146a2df
```

### 4. Verify the new image

```bash
docker images
```

The output confirmed that the image was created:

```text
REPOSITORY   TAG          IMAGE ID       CREATED          SIZE
official     datacenter   31fb51f95c4a   31 seconds ago   145MB
ubuntu       latest       b9e485d4a3bc   2 weeks ago      101MB
```

The image can also be inspected using:

```bash
docker image inspect official:datacenter
```

## Verification

The following results confirmed successful completion:

- Source container: `ubuntu_latest`
- Image repository: `official`
- Image tag: `datacenter`
- Image ID: `31fb51f95c4a`
- Image size: `145MB`

The new image was successfully created from the running container.

## Key Concepts

### Docker Containers

A Docker container is a running instance of an image. Changes made to its writable filesystem layer can be captured in a new image.

### Docker Commit

The `docker commit` command creates a new image from a container's current filesystem state.

General syntax:

```bash
docker commit CONTAINER_NAME IMAGE_NAME:TAG
```

In this challenge:

```bash
docker commit ubuntu_latest official:datacenter
```

### Reusable Docker Images

Creating an image from a container allows the captured filesystem state to be reused to create other containers.

## What I Learned

- How to identify running Docker containers using `docker ps`.
- How to create an image from an existing container.
- How to use the `docker commit` command.
- How to verify newly created images using `docker images`.
- How to inspect Docker image metadata.

## DevOps Relevance

Creating reusable Docker images is useful when preserving container changes, preparing test environments, and capturing application states.

For production workflows, building images from version-controlled Dockerfiles is generally more repeatable and easier to maintain than relying on manual container commits.

## Security and Operational Considerations

- Avoid storing passwords, access tokens, or other secrets inside container images.
- Review container changes before committing an image.
- Use descriptive image names and tags.
- Prefer Dockerfiles for reproducible image builds and maintainable CI/CD pipelines.

## Challenge Status

**Completed — Day 39/100** ✅

**KodeKloud Result Reference:** `6809e16283720aedcc71f42e`
