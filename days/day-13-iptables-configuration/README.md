# Day 13 — iptables Configuration

## Challenge

Configure firewall rules on all Nautilus application servers using `iptables`.

The requirement was to allow traffic to TCP port `3002` only from the Load Balancer while blocking access to that port from all other sources.

The firewall policy also needed to preserve existing connections, ICMP traffic, loopback traffic, and SSH access.

---

## Objective

Configure the firewall on all three Nautilus application servers so that:

* Existing connections are allowed.
* ICMP traffic is allowed.
* Loopback traffic is allowed.
* SSH traffic on port `22` is allowed.
* The Load Balancer `10.244.247.216` can access TCP port `3002`.
* All other traffic to TCP port `3002` is dropped.
* The firewall configuration persists after a reboot.

---

## Environment

| Component                | Details                   |
| ------------------------ | ------------------------- |
| Jump Host                | `thor`                    |
| App Server 1             | `stapp01`                 |
| App Server 2             | `stapp02`                 |
| App Server 3             | `stapp03`                 |
| Load Balancer            | `10.244.247.216`          |
| Protected Port           | `3002`                    |
| Firewall                 | `iptables`                |
| Persistent Configuration | `/etc/sysconfig/iptables` |

---

## Firewall Policy

The required firewall rule order was:

| Order | Traffic                                   | Action |
| ----- | ----------------------------------------- | ------ |
| 1     | Existing connections                      | ACCEPT |
| 2     | ICMP                                      | ACCEPT |
| 3     | Loopback                                  | ACCEPT |
| 4     | SSH TCP/22                                | ACCEPT |
| 5     | Load Balancer `10.244.247.216` → TCP/3002 | ACCEPT |
| 6     | Other traffic → TCP/3002                  | DROP   |
| 7     | Existing catch-all rule                   | REJECT |

Rule order is important because `iptables` evaluates rules sequentially.

The Load Balancer-specific `ACCEPT` rule must therefore appear before the broader `DROP` rule for port `3002`.

---

## Implementation

### 1. Configure the firewall policy

The firewall configuration was applied across all three Nautilus application servers:

* `stapp01`
* `stapp02`
* `stapp03`

The final configuration allows the Load Balancer to reach port `3002` while blocking other sources.

### 2. Save the persistent configuration

On `stapp03`, the active `iptables` configuration was saved to:

```text
/etc/sysconfig/iptables
```

The command used was:

```bash
sudo iptables-save | sudo tee /etc/sysconfig/iptables > /dev/null
```

This ensures the current firewall rules are written to the persistent configuration file.

### 3. Verify the port 3002 rules

The saved configuration was checked with:

```bash
sudo grep 3002 /etc/sysconfig/iptables
```

Expected rules:

```text
-A INPUT -s 10.244.247.216/32 -p tcp -m tcp --dport 3002 -j ACCEPT
-A INPUT -p tcp -m tcp --dport 3002 -j DROP
```

The first rule allows the Load Balancer to access port `3002`.

The second rule blocks all other sources from accessing port `3002`.

### 4. Verify firewall enablement

The `iptables` service was checked to confirm that it is enabled:

```bash
sudo systemctl is-enabled iptables
```

Expected result:

```text
enabled
```

This confirms that the firewall service is configured to start automatically.

---

## Final Configuration

The final firewall state across the Nautilus application servers was:

| Server    | Port 3002 | Load Balancer Exception  | Persistent |
| --------- | --------- | ------------------------ | ---------- |
| `stapp01` | Blocked   | `10.244.247.216` allowed | Yes        |
| `stapp02` | Blocked   | `10.244.247.216` allowed | Yes        |
| `stapp03` | Blocked   | `10.244.247.216` allowed | Yes        |

---

## Key Concepts

### iptables

`iptables` is a Linux firewall framework used to control network traffic based on rules.

### Rule Ordering

Rules are evaluated in order. A specific `ACCEPT` rule must be placed before a broader `DROP` rule when the specific traffic needs to be permitted.

### Source-Based Access Control

The port `3002` rule restricts access based on the source IP address:

```text
10.244.247.216 → TCP/3002 → ACCEPT
```

Other sources are denied:

```text
Any source → TCP/3002 → DROP
```

### Firewall Persistence

Active firewall rules can be saved to:

```text
/etc/sysconfig/iptables
```

This allows the configuration to survive a system restart.

---

## DevOps Relevance

Firewall configuration is an important part of infrastructure and platform engineering.

This challenge demonstrates:

* Linux network security
* Infrastructure hardening
* Source-based access control
* Least-privilege network access
* Service configuration
* Persistent infrastructure configuration
* Troubleshooting and verification

In a production environment, the same principles can be applied when restricting application ports to trusted services such as load balancers, reverse proxies, monitoring systems, or internal application components.

---

## Security Considerations

* Only the trusted Load Balancer IP should be permitted to access port `3002`.
* The broad `DROP` rule must come after the Load Balancer `ACCEPT` rule.
* SSH access must remain available to prevent administrative lockout.
* Existing connections should be preserved.
* Firewall configuration should be persisted so that security controls remain active after reboot.
* Firewall rules should be reviewed carefully before applying them to production systems.

---

## What I Learned

This challenge reinforced that firewall security depends not only on which rules exist, but also on their order.

The important pattern was:

```text
Trusted source → ACCEPT
Everything else → DROP
```

I also learned that configuring the active firewall is only part of the task. The rules must also be saved to the persistent configuration and the firewall service must be enabled.

---

## Commands

The commands used during the persistence and verification stage are documented in [`commands.sh`](./commands.sh).

---

## Challenge Status

**Completed — Day 13/100** ✅
