# Day 14 — Apache Service Troubleshooting

## Challenge

Monitoring reported that Apache was unavailable on one of the Nautilus application servers in the Stratos Datacenter.

The requirement was to identify the faulty server, troubleshoot the Apache service, resolve the issue, and ensure Apache was running and listening on port `6200` across all application servers.

---

## Objective

* Identify the application server where Apache was failing.
* Determine why Apache could not start.
* Resolve the underlying service/port conflict.
* Ensure Apache is running on all application servers.
* Ensure Apache is listening on TCP port `6200`.
* Verify connectivity from the jump host.

---

## Environment

| Component           | Details                         |
| ------------------- | ------------------------------- |
| Datacenter          | Stratos Datacenter              |
| Application Servers | `stapp01`, `stapp02`, `stapp03` |
| Web Server          | Apache HTTP Server (`httpd`)    |
| Required Port       | `6200`                          |
| Operating System    | CentOS Stream                   |
| Verification Host   | Jump Host                       |

---

## Problem Identification

The Apache service was checked on `stapp01`:

```bash
sudo systemctl status httpd --no-pager
```

The service was in a failed state.

The Apache logs reported:

```text
(98)Address already in use
```

Apache was unable to bind to:

```text
[::]:6200
0.0.0.0:6200
```

This indicated that another process was already using TCP port `6200`.

---

## Root Cause

The faulty server was identified as:

```text
stapp01
```

The root cause was a **port conflict**.

The `sendmail` service was occupying TCP port `6200`, preventing Apache from binding to the required port.

---

## Resolution

The conflicting `sendmail` service was stopped and disabled on `stapp01`.

Apache was then started successfully and configured to start automatically.

Apache was also enabled on the remaining application servers to ensure the service remained available after a reboot.

Final application-server state:

| Server    | Apache  | Port   |
| --------- | ------- | ------ |
| `stapp01` | Running | `6200` |
| `stapp02` | Running | `6200` |
| `stapp03` | Running | `6200` |

---

## Verification

Connectivity was tested from the jump host against all three application servers:

```bash
for server in stapp01 stapp02 stapp03; do
  echo "=== $server ==="
  curl -I --connect-timeout 5 http://$server:6200
done
```

All three servers responded successfully.

The response was:

```text
HTTP/1.1 403 Forbidden
Server: Apache/2.4.62 (CentOS Stream)
```

A `403 Forbidden` response is acceptable for this challenge because the requirement was to ensure Apache was running and reachable on port `6200`; no specific web page needed to be served.

---

## Final Configuration

The final state was:

* `stapp01` — Apache running and listening on port `6200`.
* `stapp02` — Apache running and listening on port `6200`.
* `stapp03` — Apache running and listening on port `6200`.
* Conflicting `sendmail` service removed from the port conflict on `stapp01`.
* Apache configured to start automatically.
* Connectivity verified from the jump host.

---

## Key Concepts

### Port Conflicts

Only one process can normally bind to the same IP address and TCP port combination.

When Apache reported:

```text
Address already in use
```

it indicated that another process had already claimed port `6200`.

### Service Dependencies

A web server can be correctly configured but still fail to start if another service occupies its required port.

Troubleshooting therefore requires checking both:

1. The application service.
2. Other processes/services using the required resources.

### Service Persistence

Enabling Apache ensures that the service starts automatically after a system reboot.

Disabling an unnecessary conflicting service prevents the same conflict from returning.

---

## DevOps Relevance

This task demonstrates practical infrastructure troubleshooting skills:

* Linux service management
* Apache troubleshooting
* Port conflict investigation
* Service dependency analysis
* Persistent service configuration
* Network connectivity testing
* Remote infrastructure verification

These are common responsibilities when supporting production application infrastructure.

---

## Security and Operational Considerations

When troubleshooting a production server:

* Avoid stopping unrelated services without understanding their purpose.
* Identify the process occupying the required port before making changes.
* Verify that disabling a service will not break another application.
* Confirm the target service is running after making changes.
* Test connectivity from the same network location used by the application or monitoring system.
* Configure required services to start automatically when appropriate.

---

## What I Learned

This challenge reinforced that a failed application service does not always mean the application itself is misconfigured.

Apache was failing because another service was already using the required port.

The important troubleshooting sequence was:

```text
Service failure
      ↓
Check service status/logs
      ↓
Identify port conflict
      ↓
Find conflicting service
      ↓
Resolve conflict
      ↓
Start/configure Apache
      ↓
Verify remotely
```

This is a useful troubleshooting pattern for Linux-based application and infrastructure environments.

---

## Commands

The commands shown during the lab are documented in [`commands.sh`](./commands.sh).

---

## Challenge Status

Completed — Day 14/100 ✅
