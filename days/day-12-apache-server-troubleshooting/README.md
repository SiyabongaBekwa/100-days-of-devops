# Day 12 — Apache Server Troubleshooting

## Challenge

Ensure that the Apache (`httpd`) service is running correctly on the Nautilus application servers and that the web servers are reachable from the jump host on **TCP port 8088**.

## Objective

The objective was to troubleshoot the Apache web server on the application servers and ensure that requests to port `8088` could reach all three servers.

The troubleshooting process involved:

* Testing connectivity from the jump host.
* Diagnosing Apache service failures.
* Identifying a port conflict on `stapp01`.
* Restoring the Apache service.
* Investigating firewall rules.
* Allowing TCP port `8088` through `iptables`.
* Verifying connectivity to all application servers.

## Environment

| Component    | Details                      |
| ------------ | ---------------------------- |
| Jump Host    | `thor`                       |
| App Server 1 | `stapp01` / `tony`           |
| App Server 2 | `stapp02` / `steve`          |
| App Server 3 | `stapp03` / `banner`         |
| Web Server   | Apache HTTP Server (`httpd`) |
| HTTP Port    | `8088`                       |

## Implementation

### 1. Test Connectivity

Connectivity to the application servers was tested from the jump host using `curl`.

```bash
curl -I http://stapp01:8088
curl -I http://stapp02:8088
curl -I http://stapp03:8088
```

`stapp01` initially returned a **No route to host** error, while `stapp02` and `stapp03` were reachable.

This indicated that further troubleshooting was required on `stapp01`.

### 2. Diagnose Apache on `stapp01`

After connecting to `stapp01`, the Apache service status was checked.

```bash
sudo systemctl status httpd
```

The service was failing to start.

The Apache logs indicated that port `8088` was already in use.

The configured Apache listening port was also verified:

```bash
sudo grep -n "^Listen" /etc/httpd/conf/httpd.conf
```

The configuration showed:

```text
Listen 8088
```

### 3. Identify the Port Conflict

The process using port `8088` was identified with:

```bash
sudo ss -lntp | grep 8088
```

The output showed that `sendmail` was listening on:

```text
127.0.0.1:8088
```

The process ID was `23307`.

This prevented Apache from binding to port `8088`.

### 4. Resolve the Port Conflict

The conflicting `sendmail` process was terminated:

```bash
sudo kill -9 23307
```

Apache was then started and enabled:

```bash
sudo systemctl start httpd
sudo systemctl enable httpd
```

The service was verified afterwards:

```bash
sudo systemctl status httpd
```

Apache was successfully running and listening on port `8088`.

### 5. Verify Apache Locally

A local request was made from `stapp01`:

```bash
curl -I http://localhost:8088
```

Apache returned:

```text
HTTP/1.1 403 Forbidden
```

The `403 Forbidden` response confirmed that Apache itself was responding.

The response was not treated as an Apache connectivity failure. The important result at this stage was that the HTTP service was reachable locally.

### 6. Diagnose the Firewall

The firewall configuration was investigated.

The `firewall-cmd` command was not available:

```bash
sudo firewall-cmd --list-all
```

The command returned:

```text
sudo: firewall-cmd: command not found
```

SELinux was checked:

```bash
getenforce
```

The result was:

```text
Disabled
```

The active `iptables` rules were then inspected:

```bash
sudo iptables -L -n -v
```

The rules showed that SSH traffic on port `22` was allowed, followed by a final rejection rule.

This explained why the service was working locally but external requests to port `8088` were being blocked.

### 7. Allow TCP Port 8088

A rule was inserted into the `INPUT` chain to allow TCP traffic on port `8088`:

```bash
sudo iptables -I INPUT 4 -p tcp --dport 8088 -j ACCEPT
```

The rules were then verified:

```bash
sudo iptables -L -n -v
```

The new rule allowing TCP port `8088` was present.

### 8. Attempt to Save the Firewall Rule

An attempt was made to persist the `iptables` configuration:

```bash
sudo service iptables save
```

However, the command failed because the `service` command was not available in the environment.

This was documented as a limitation encountered during the challenge. The active firewall rule was nevertheless sufficient for the challenge to pass.

### 9. Final Connectivity Test

After correcting the firewall configuration, connectivity was tested again from the jump host:

```bash
curl -I http://stapp01:8088
curl -I http://stapp02:8088
curl -I http://stapp03:8088
```

All three application servers returned:

```text
HTTP/1.1 403 Forbidden
```

The `403` response confirmed that the HTTP requests were successfully reaching Apache.

## Final Configuration

| Server    | Apache Status       |   Port | Connectivity |
| --------- | ------------------- | -----: | ------------ |
| `stapp01` | Running and enabled | `8088` | Working      |
| `stapp02` | Working             | `8088` | Working      |
| `stapp03` | Working             | `8088` | Working      |

### `stapp01` Fix

The main issues on `stapp01` were:

1. `sendmail` was occupying TCP port `8088`.
2. Apache could therefore not bind to the configured port.
3. After resolving the port conflict, `iptables` was blocking external access to port `8088`.
4. An `iptables` rule was added to allow TCP port `8088`.

## Troubleshooting

### Apache failed to start

Apache could not bind to port `8088` because another process was already using the port.

The conflicting process was identified using:

```bash
sudo ss -lntp | grep 8088
```

### Apache worked locally but not remotely

The local test:

```bash
curl -I http://localhost:8088
```

returned `HTTP/1.1 403 Forbidden`, proving Apache was responding.

The problem was therefore investigated at the network/firewall layer.

### Firewall command unavailable

`firewall-cmd` was unavailable in the environment, so `iptables` was used to inspect and modify the active firewall rules.

### Firewall persistence command failed

The command:

```bash
sudo service iptables save
```

failed because `service` was unavailable.

This is recorded as an observed limitation rather than a successful persistence step.

## Key Concepts

### Port Conflict

Only one process can bind to the same IP/port combination. Since `sendmail` was already using port `8088`, Apache could not start correctly.

### Systemd Service Management

`systemctl` was used to start, enable, and inspect the Apache service.

### Firewall Troubleshooting

A service can be healthy locally while still being inaccessible remotely because firewall rules can block incoming traffic.

### HTTP 403 vs Connectivity

An HTTP `403 Forbidden` response still proves that the request reached the web server. It is different from a network-level error such as `No route to host`.

### Service Enablement

Enabling Apache ensures the service is configured to start automatically during system boot.

## DevOps Relevance

This challenge demonstrates several practical DevOps troubleshooting skills:

* Linux service management
* Apache troubleshooting
* Network connectivity testing
* Port conflict investigation
* Firewall troubleshooting
* `iptables` rule management
* Log-based diagnosis
* Remote service verification
* Distinguishing application-layer errors from network-layer failures

These skills are important when diagnosing failed deployments, unavailable services, and infrastructure connectivity problems.

## Security Considerations

* Firewall rules should allow only required ports.
* Opening TCP `8088` should be limited to the traffic required by the application architecture.
* Disabling or terminating services should only be done after confirming that they are causing the conflict and are not required.
* Firewall configuration changes should be reviewed for persistence and consistency after system restarts.
* Administrative commands should be executed with appropriate privileges.

## What I Learned

This challenge reinforced that troubleshooting should be performed systematically.

A failed web request does not necessarily mean that Apache itself is broken. The investigation needs to consider:

1. Whether the service is running.
2. Whether the required port is available.
3. Whether another process is using the port.
4. Whether the application responds locally.
5. Whether firewall rules allow external traffic.
6. Whether the service is reachable remotely.

The most important lesson was to isolate the problem layer by layer instead of changing configuration blindly.

## Commands

The commands used during the challenge are documented in [`commands.sh`](./commands.sh).

## Challenge Status

**Completed — Day 12/100** ✅
