# Day 42 — Create a Custom Docker Bridge Network

## Overview

This challenge focused on creating and configuring a custom Docker bridge network with a specific subnet and IP address range.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Create a Docker network named `news` on Application Server 3 (`stapp03`) with the following configuration:

- Network name: `news`
- Driver: `bridge`
- Subnet: `172.168.0.0/24`
- IP range: `172.168.0.0/24`

## Environment

| Component | Details |
|---|---|
| Platform | KodeKloud |
| Environment | Nautilus / Stratos Datacenter |
| Server | App Server 3 (`stapp03`) |
| User | `banner` |
| Technology | Docker |
| Task | Custom Docker Network |

## Implementation

### 1. Connect to App Server 3

```bash
ssh banner@stapp03
```

### 2. Create the Docker Network

```bash
docker network create \
  --driver bridge \
  --subnet 172.168.0.0/24 \
  --ip-range 172.168.0.0/24 \
  news
```

### 3. Verify the Network

List the available Docker networks:

```bash
docker network ls
```

Inspect the custom network:

```bash
docker network inspect news
```

## Verification

The network inspection confirmed the following configuration:

| Property | Verified value |
|---|---|
| Name | `news` |
| Driver | `bridge` |
| Scope | `local` |
| Subnet | `172.168.0.0/24` |
| IP range | `172.168.0.0/24` |

Docker returned the following network ID:

```text
00bb87d3a2fe3f588a28687b44ff9a6da2c8946189e9b5e401e9b1b13969bbee
```

The KodeKloud challenge was successfully validated.

## Key Concepts

### Docker Networks

Docker networks allow containers to communicate with one another and connect to external networks.

### Bridge Driver

The bridge driver creates a software-based network on the Docker host. It allows containers connected to that network to communicate.

### Subnet

A subnet defines the IP address range available to devices connected to a network.

### IP Range

The IP range specifies the addresses Docker can allocate to containers within the configured subnet.

### Network Inspection

The `docker network inspect` command provides detailed information about a Docker network, including its driver, subnet, IP range, and connected containers.

## DevOps Relevance

Custom Docker networks are useful when:

- Separating application environments.
- Enabling communication between related containers.
- Controlling container IP address allocation.
- Designing container-based infrastructure.
- Building multi-container application environments.

## What I Learned

- How to create custom Docker bridge networks.
- How to configure network subnets and IP ranges.
- How to list and inspect Docker networks.
- How to verify network configuration against infrastructure requirements.

## Challenge Status

**Completed — Day 42/100** ✅

**KodeKloud Result Reference:** `6809e3d983720aedcc71f431`
