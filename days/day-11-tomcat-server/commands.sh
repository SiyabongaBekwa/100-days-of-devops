```bash
#!/bin/bash

# Day 11 — Configure Tomcat Server
# Server: stapp02
# User: steve
# Tomcat: 9.0.117
# HTTP Port: 8087

# Verify Tomcat service status
systemctl status tomcat --no-pager

# Verify Tomcat HTTP connector
# Expected in the Tomcat logs:
# Http11Nio-8087

# Verify ROOT.war deployment
# Expected in the Tomcat logs:
# ROOT.war

# Test the application
curl http://stapp02:8087

# Verify HTTP response headers and status
curl -I http://stapp02:8087
```
