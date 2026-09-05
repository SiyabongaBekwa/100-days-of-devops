#!/bin/bash

# Day 13 — iptables Configuration

#

# This file documents the commands used during the lab.

# Commands were executed interactively on the relevant app servers.

# Save the active iptables configuration

sudo iptables-save | sudo tee /etc/sysconfig/iptables > /dev/null

# Verify the port 3002 rules in the persistent configuration

sudo grep 3002 /etc/sysconfig/iptables

# Verify that the iptables service is enabled

sudo systemctl is-enabled iptables

# Verify the port 3002 rules again

sudo grep 3002 /etc/sysconfig/iptables
