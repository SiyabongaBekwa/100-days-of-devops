```bash
#!/bin/bash

# ============================================================
# Day 4: Script Execution Permissions
# ============================================================
#
# Objective:
# Grant executable permissions to the xfusioncorp.sh script.
#
# NOTE:
# Replace <user> and <server> with the SSH details provided
# by the KodeKloud lab.
#
# Do NOT store passwords, private keys, tokens, or credentials
# in this file.
#
# ============================================================


# ============================================================
# 1. Connect to the application server
# ============================================================

ssh <user>@<server>


# ============================================================
# 2. Check the existing script permissions
# ============================================================

ls -l /tmp/xfusioncorp.sh


# ============================================================
# 3. Grant execute permission
# ============================================================
#
# a  = all users
# +x = add execute permission
#
# This grants execute permission to the owner, group, and others.

chmod a+x /tmp/xfusioncorp.sh


# ============================================================
# 4. Verify the updated permissions
# ============================================================

ls -l /tmp/xfusioncorp.sh


# ============================================================
# 5. Execute the script
# ============================================================

/tmp/xfusioncorp.sh


# ============================================================
# Additional verification
# ============================================================


# Check the file type

file /tmp/xfusioncorp.sh


# Display detailed file information

stat /tmp/xfusioncorp.sh


# ============================================================
# Troubleshooting
# ============================================================


# Check whether the script exists

ls -l /tmp/xfusioncorp.sh


# If execute permission is missing, grant it again

chmod a+x /tmp/xfusioncorp.sh


# Execute using Bash if required

bash /tmp/xfusioncorp.sh


# ============================================================
# End of Day 4
# ============================================================
```
