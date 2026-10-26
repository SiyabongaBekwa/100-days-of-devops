# Day 38 — Pull and Retag a Docker Image

## Overview

This challenge focused on pulling a Docker image from a registry and assigning it a new tag for testing purposes.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Pull the `busybox:musl` image on App Server 1 and retag it as `busybox:news`.

## Environment

| Component | Details |
|---|---|
| Platform | KodeKloud |
| Environment | Nautilus / Stratos Datacenter |
| Server | App Server 1 (`stapp01`) |
| User | `tony` |
| Technology | Docker |
| Original image | `busybox:musl` |
| New tag | `busybox:news` |

## Implementation

### 1. Connect to App Server 1

```bash
ssh tony@stapp01
```

### 2. Pull the Docker image

```bash
docker pull busybox:musl
```

### 3. Retag the image

```bash
docker tag busybox:musl busybox:news
```

### 4. Verify the image tags

```bash
docker images busybox
```

The output confirmed both tags were present:

```text
REPOSITORY   TAG    IMAGE ID       CREATED        SIZE
busybox      musl   fd01c2c0be3f   5 months ago   1.53MB
busybox      news   fd01c2c0be3f   5 months ago   1.53MB
```

## Verification

Both `busybox:musl` and `busybox:news` reference the same image ID:

`fd01c2c0be3f`

This confirms that the new tag was assigned to the existing local image. Retagging does not create a separate image or require another download.

## Key Concepts

### Docker Image Tags

Tags identify particular versions or variants of Docker images. They make it easier to reference images consistently across development and testing environments.

### Retagging Images

The `docker tag` command assigns another name and tag to an existing local image.

```bash
docker tag SOURCE_IMAGE:SOURCE_TAG TARGET_IMAGE:TARGET_TAG
```

### Image Verification

The `docker images` command lists local images and their tags, image IDs, and sizes. Matching image IDs can confirm that two tags refer to the same underlying image.

## What I Learned

- How to pull a specific Docker image tag.
- How to assign a new tag to an existing image.
- How to verify image tags using Docker CLI commands.
- Why image IDs are useful when checking whether tags reference the same image.

## DevOps Relevance

Docker image management is important in containerized development, CI/CD pipelines, testing workflows, and deployment processes. Consistent tagging helps teams identify and promote the intended image between environments.

## Challenge Status

**Completed — Day 38/100** ✅

**KodeKloud Result Reference:** `6809e00e83720aedcc71f42c`

## Security Considerations

Use trusted image sources and appropriate image versions. Avoid including passwords, access tokens, or other sensitive credentials in repository documentation.
