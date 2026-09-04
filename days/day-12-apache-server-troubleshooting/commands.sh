```bash
#!/bin/bash

# Day 12 — Apache Server Troubleshooting
# This file documents the commands used during the lab.
# Some commands are host-specific and were used interactively.

# --------------------------------------------------
# 1. Test connectivity from the jump host
# --------------------------------------------------

curl -I http://stapp01:8088
curl -I http://stapp02:8088
curl -I http://stapp03:8088


# --------------------------------------------------
# 2. Diagnose Apache on stapp01
# --------------------------------------------------

sudo systemctl status httpd

sudo ss -lntp | grep httpd

sudo grep -n "^Listen" /etc/httpd/conf/httpd.conf


# --------------------------------------------------
# 3. Identify the process using port 8088
# --------------------------------------------------

sudo ss -lntp | grep 8088


# --------------------------------------------------
# 4. Resolve the port conflict
# --------------------------------------------------

# PID 23307 was the sendmail process identified during
# the original lab session.
sudo kill -9 23307

sudo systemctl start httpd

sudo systemctl enable httpd

sudo systemctl status httpd

sudo ss -lntp | grep httpd


# --------------------------------------------------
# 5. Test Apache locally
# --------------------------------------------------

curl -I http://localhost:8088


# --------------------------------------------------
# 6. Diagnose firewall and network configuration
# --------------------------------------------------

sudo firewall-cmd --list-all

getenforce

sudo iptables -L -n -v

ip addr show

ip route show


# --------------------------------------------------
# 7. Allow TCP port 8088 through iptables
# --------------------------------------------------

sudo iptables -I INPUT 4 -p tcp --dport 8088 -j ACCEPT

sudo iptables -L -n -v


# --------------------------------------------------
# 8. Attempt to save the firewall configuration
# --------------------------------------------------

# This command was attempted during the lab but failed
# because the 'service' command was unavailable.
sudo service iptables save


# --------------------------------------------------
# 9. Final verification from the jump host
# --------------------------------------------------

curl -I http://stapp01:8088
curl -I http://stapp02:8088
curl -I http://stapp03:8088
```
