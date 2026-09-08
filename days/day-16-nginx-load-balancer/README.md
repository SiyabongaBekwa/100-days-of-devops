# Day 16 — Nginx Load Balancer Configuration

## Overview

This challenge focused on configuring an Nginx server as a load balancer for the Nautilus production environment.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

The objective was to configure the existing Load Balancer (LBR) server so that incoming HTTP traffic could be distributed across all three App Servers.

## Objective

Configure the Nautilus Load Balancer server (`stlb01`) to distribute HTTP traffic across:

* `stapp01`
* `stapp02`
* `stapp03`

The configuration had to use Nginx's `http` context and modify only the main Nginx configuration file:

```text
/etc/nginx/nginx.conf
```

The existing Apache configuration and ports on the App Servers had to remain unchanged.

## Environment

| Component          | Details                       |
| ------------------ | ----------------------------- |
| Platform           | KodeKloud                     |
| Environment        | Nautilus / Stratos Datacenter |
| Load Balancer      | `stlb01`                      |
| LBR User           | `loki`                        |
| App Server 1       | `stapp01`                     |
| App Server 2       | `stapp02`                     |
| App Server 3       | `stapp03`                     |
| Operating System   | CentOS Stream 9               |
| Nginx              | 1.20.1                        |
| Protocol           | HTTP                          |
| Load Balancer Port | 80                            |

## Task Requirements

The task required the following:

1. Install Nginx on the LBR server if it was not already installed.
2. Configure Nginx load balancing using the `http` context.
3. Include all three App Servers as backend servers.
4. Modify only `/etc/nginx/nginx.conf`.
5. Do not change the existing Apache ports on the App Servers.
6. Ensure Apache is running on all App Servers.
7. Verify the application through the Load Balancer using:

```bash
curl http://stlb01:80
```

## Implementation

### 1. Connect to the Load Balancer

The LBR server was accessed using SSH:

```bash
ssh loki@stlb01
```

### 2. Verify the Operating System

The operating system was checked with:

```bash
cat /etc/os-release
```

The server was running:

```text
CentOS Stream 9
```

### 3. Verify Nginx Installation

The installed Nginx version was checked using:

```bash
nginx -v
```

The output confirmed that Nginx was already installed:

```text
nginx version: nginx/1.20.1
```

Therefore, no additional Nginx installation was required.

## Load Balancer Architecture

The target architecture was:

```text
                    Client
                      |
                      | HTTP :80
                      v
              +----------------+
              |   stlb01       |
              | Nginx LBR      |
              +----------------+
                 /     |     \
                /      |      \
               v       v       v
          stapp01  stapp02  stapp03
           Apache    Apache    Apache
```

Nginx acts as the frontend Load Balancer and distributes incoming HTTP requests across the three App Servers.

## Nginx Configuration

The load-balancing configuration was required to be implemented in the main Nginx configuration file:

```text
/etc/nginx/nginx.conf
```

The configuration uses Nginx's `http` context and includes all three App Servers as upstream backend servers.

The existing Apache ports on the App Servers were preserved as required by the challenge.

## Verification

The completed configuration was verified by accessing the Load Balancer on port 80:

```bash
curl http://stlb01:80
```

A successful response confirms that the request can reach the application through the Nginx Load Balancer.

## Key Concepts

### Load Balancing

Load balancing distributes incoming client requests across multiple backend servers.

This improves:

* Availability
* Scalability
* Fault tolerance
* Application performance

### Reverse Proxy

Nginx receives requests from clients and forwards them to backend App Servers.

The client communicates with the Load Balancer rather than directly accessing the backend servers.

### Nginx HTTP Context

Nginx load-balancing configuration can be defined within the `http` configuration context.

This allows Nginx to manage HTTP traffic and route requests to configured backend servers.

### High Availability

Using multiple App Servers behind a Load Balancer reduces dependence on a single application server.

If one backend becomes unavailable, traffic can potentially be handled by the remaining servers.

## DevOps Relevance

Load balancing is a fundamental infrastructure concept used in:

* Production web applications
* Cloud architectures
* High-availability environments
* Reverse-proxy architectures
* Microservices
* Kubernetes
* Container platforms
* Azure and AWS infrastructure

This challenge demonstrates how multiple application servers can be placed behind a single entry point, which is a common production architecture.

## What I Learned

* How Nginx can be used as a Load Balancer.
* How multiple backend servers can be placed behind a single frontend endpoint.
* The role of Nginx's `http` context in HTTP traffic management.
* The importance of preserving existing application-server configurations.
* How Load Balancers contribute to high-availability architectures.
* How to verify a Load Balancer using `curl`.

## Security and Configuration Considerations

The challenge required the existing Apache ports on the App Servers to remain unchanged.

Only the main Nginx configuration file was intended to be modified:

```text
/etc/nginx/nginx.conf
```

No credentials, passwords, private keys, or other sensitive information are stored in this repository.

## Challenge Status

**Completed — Day 16/100** ✅

