```bash
#!/bin/bash

# Day 14 — Apache Service Troubleshooting
#
# This file documents the commands shown during the lab.
# Commands were executed interactively on the relevant hosts.

# Check Apache service status on stapp01
sudo systemctl status httpd --no-pager

# Verify Apache is reachable on port 6200 from the jump host
for server in stapp01 stapp02 stapp03; do
  echo "=== $server ==="
  curl -I --connect-timeout 5 http://$server:6200
done
```
