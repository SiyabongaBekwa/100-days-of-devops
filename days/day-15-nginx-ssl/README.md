# Day 15 — Nginx SSL Configuration

## 📌 Challenge

The xFusionCorp Industries system administrators needed to prepare **App Server 1** in the Stratos Datacenter for a new application deployment.

The requirements were:

1. Install and configure Nginx on App Server 1.
2. Move the existing self-signed SSL certificate and key from `/tmp/nautilus.crt` and `/tmp/nautilus.key` to an appropriate location and deploy them in Nginx.
3. Create an `index.html` file containing `Welcome!` under the Nginx document root.
4. Verify HTTPS access from the jump host using the App Server hostname.

## 🖥️ Server

| Item               | Details             |
| ------------------ | ------------------- |
| Server             | `stapp01`           |
| Application Server | App Server 1        |
| User               | `tony`              |
| Operating System   | CentOS Stream 9     |
| Web Server         | Nginx               |
| SSL Certificate    | `/tmp/nautilus.crt` |
| SSL Key            | `/tmp/nautilus.key` |
| Required Page      | `Welcome!`          |

## 🔧 Work Completed

### 1. Connected to App Server 1

```bash
ssh tony@stapp01
```

### 2. Verified the Operating System

```bash
cat /etc/os-release
```

The server was running **CentOS Stream 9**.

### 3. Installed Nginx

```bash
sudo dnf install -y nginx
```

Nginx was successfully installed.

Installed Nginx version:

```text
nginx-2:1.20.1-31.el9.x86_64
```

## 🎯 Requirements

The remaining configuration for this challenge involves:

* Deploying the existing SSL certificate and key in Nginx.
* Configuring HTTPS.
* Creating the required `index.html` containing `Welcome!`.
* Testing HTTPS access from the jump host using the App Server hostname.

## 🧠 DevOps Concepts

This task demonstrates several practical infrastructure and DevOps concepts:

* Linux server administration
* Package management with `dnf`
* Nginx installation and configuration
* SSL/TLS certificate deployment
* HTTPS configuration
* Web server document roots
* Infrastructure troubleshooting and verification
* Testing services remotely from a jump host

## Challenge Status

Completed — Day 15/100 ✅
