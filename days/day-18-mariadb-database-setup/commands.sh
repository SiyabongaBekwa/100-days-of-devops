```bash
#!/bin/bash

# Day 18 - MariaDB Database Setup
# KodeKloud 100 Days of DevOps
#
# Note:
# The commands below document the commands used during the challenge.
# The actual database password is intentionally excluded.

# Initial checks accidentally performed on the jump host.
# These failed because MariaDB was not installed there and systemd
# was not available in that environment.
mariadb --version
sudo systemctl status mariadb --no-pager

# Connect to the Nautilus database server.
ssh peter@stdb01

# Check whether MariaDB is installed.
mariadb --version

# Install MariaDB Server.
sudo dnf install -y mariadb-server

# Enable and start MariaDB.
sudo systemctl enable --now mariadb

# Verify the MariaDB service.
sudo systemctl status mariadb --no-pager

# Open the MariaDB console.
sudo mariadb

# Create the database.
CREATE DATABASE kodekloud_db2;

# Create the database user.
# Replace <database-password> with the actual password when executing.
CREATE USER 'kodekloud_aim'@'localhost' IDENTIFIED BY '<database-password>';

# Grant full privileges on the database.
GRANT ALL PRIVILEGES ON kodekloud_db2.* TO 'kodekloud_aim'@'localhost';

# Verify the database.
SHOW DATABASES LIKE 'kodekloud_db2';

# Verify the database user.
SELECT User, Host FROM mysql.user WHERE User = 'kodekloud_aim';

# Verify the user's permissions.
SHOW GRANTS FOR 'kodekloud_aim'@'localhost';

# Exit MariaDB.
exit;
```
