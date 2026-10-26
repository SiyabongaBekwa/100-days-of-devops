# Day 37 — Docker File Transfer and Integrity Verification

## Overview

This challenge focused on copying an encrypted file from a Docker host into a running container without modifying its contents.

The task was completed as part of the KodeKloud **100 Days of DevOps** challenge in the Nautilus infrastructure environment.

## Objective

Copy `/tmp/nautilus.txt.gpg` from App Server 3 into the `/usr/src/` directory of the running `ubuntu_latest` container and verify that the file remains unchanged.

## Environment

| Component | Details |
|---|---|
| Platform | KodeKloud |
| Environment | Nautilus / Stratos Datacenter |
| Server | `stapp03` |
| User | `banner` |
| Technology | Docker |
| Container | `ubuntu_latest` |
| Source file | `/tmp/nautilus.txt.gpg` |
| Destination file | `/usr/src/nautilus.txt.gpg` |

## Implementation

### 1. Connect to App Server 3

Connected to the server from the jump host.

```bash
ssh banner@stapp03
```

### 2. Verify the Container and Source File

Checked that the container was running and that the encrypted file existed on the Docker host.

```bash
docker ps
ls -l /tmp/nautilus.txt.gpg
```

### 3. Copy the File into the Container

Used `docker cp` to copy the encrypted file into the container.

```bash
docker cp /tmp/nautilus.txt.gpg ubuntu_latest:/usr/src/
```

The command copies the file without decrypting or intentionally changing its contents.

### 4. Verify the Destination File

Checked that the file existed at the expected location inside the container.

```bash
docker exec ubuntu_latest ls -l /usr/src/nautilus.txt.gpg
```

### 5. Verify File Integrity

Calculated the SHA-256 checksum of the source file and compared it with the checksum of the copied file.

```bash
sha256sum /tmp/nautilus.txt.gpg
docker exec ubuntu_latest sha256sum /usr/src/nautilus.txt.gpg
```

Both commands returned the same checksum:

```text
65893d4cb1239d7b8db2581337ca43b70999b9c5d28f4feb7cf0da491dc09b5d
```

Matching SHA-256 checksums confirmed that the source and destination files had identical contents.

## Key Concepts

### Docker Copy

The `docker cp` command transfers files and directories between a container and the local filesystem of the Docker host.

### Container Execution

The `docker exec` command runs a command inside a running container. It was used to inspect the copied file and calculate its checksum.

### SHA-256 Integrity Verification

SHA-256 produces a cryptographic hash of file contents. Matching hashes provide strong evidence that the files are identical.

### Encrypted Files

The `.gpg` extension indicates a file associated with GPG encryption. The task required transferring the encrypted file without decrypting it.

## DevOps Relevance

File transfers between hosts and containers are useful when handling configuration files, application assets, test data, and operational artifacts.

Integrity checks are especially important when transferring sensitive or encrypted files because they help verify that data was not accidentally changed during the operation.

## What I Learned

- How to copy files from a Docker host into a container
- How to use `docker exec` to run commands inside a running container
- How to verify file existence inside a container
- How to compare SHA-256 checksums
- How to validate file integrity without decrypting the file

## Security Considerations

- Avoid exposing encrypted or confidential files unnecessarily.
- Do not commit sensitive files or encryption keys to a Git repository.
- Verify file integrity after important transfers.
- Use appropriate access permissions for sensitive data.

## Challenge Status

**Completed — Day 37/100** ✅

**Container:** `ubuntu_latest`

**Integrity Check:** SHA-256 checksums matched.

**KodeKloud Result Reference:** `6809dfb783720aedcc71f42b`
