# Day 11 — Configure Tomcat Server

## Challenge

Configure a Tomcat server on **App Server 2** in the Nautilus datacenter and make the application available on the required HTTP port.

## Objective

The objective was to:

* Configure Tomcat on **App Server 2**
* Configure the Tomcat HTTP connector to use port `8087`
* Deploy the provided `ROOT.war` application
* Ensure the Tomcat service is running
* Ensure Tomcat starts automatically after a reboot
* Verify that the application is accessible through the required base URL

## Environment

| Component            | Details               |
| -------------------- | --------------------- |
| Application Server   | `stapp02`             |
| User                 | `steve`               |
| Application          | Tomcat                |
| Tomcat Version       | `9.0.117`             |
| HTTP Port            | `8087`                |
| Application Artifact | `ROOT.war`            |
| Application URL      | `http://stapp02:8087` |

## Implementation

### 1. Configure Tomcat

Tomcat was configured on **App Server 2 (`stapp02`)**.

The Tomcat HTTP connector was configured to listen on port:

```text
8087
```

### 2. Deploy the Application

The provided `ROOT.war` application was deployed to Tomcat.

Tomcat logs confirmed that the application was detected and deployed:

```text
ROOT.war
```

The deployment resulted in the application being served as the root application.

### 3. Start and Enable Tomcat

The Tomcat service was started and verified as running.

The service status showed:

```text
Active: active (running)
```

The service was also enabled, allowing Tomcat to start automatically after a system reboot.

## Verification

### Verify Tomcat Service

The Tomcat service status confirmed that the service was running:

```text
Active: active (running)
```

The logs also confirmed that Tomcat successfully initialized the HTTP connector:

```text
Http11Nio-8087
```

This confirmed that Tomcat was listening on the required port `8087`.

### Verify Application Deployment

Tomcat detected and deployed:

```text
ROOT.war
```

This confirmed that the application artifact was successfully deployed.

### Test the Application

The required base URL was tested from App Server 2:

```bash
curl http://stapp02:8087
```

The application returned the expected HTML response containing:

```text
Welcome to xFusionCorp Industries!
```

### Verify HTTP Status

The HTTP response headers were checked using:

```bash
curl -I http://stapp02:8087
```

The response returned:

```text
HTTP/1.1 200
```

This confirmed that the application was successfully accessible over HTTP.

## Final Configuration

| Requirement                          | Status |
| ------------------------------------ | ------ |
| Tomcat configured on `stapp02`       | ✅      |
| Tomcat version `9.0.117`             | ✅      |
| HTTP connector configured for `8087` | ✅      |
| `ROOT.war` deployed                  | ✅      |
| Tomcat service running               | ✅      |
| Tomcat enabled at boot               | ✅      |
| Application accessible               | ✅      |
| HTTP response `200`                  | ✅      |

## Key Concepts

### Apache Tomcat

Tomcat is a Java application server and servlet container commonly used to host Java web applications.

### WAR Deployment

A **WAR (Web Application Archive)** packages a Java web application for deployment to a servlet container such as Tomcat.

### ROOT Application

Deploying an application as `ROOT.war` makes it available at the server's base context rather than requiring an additional application path.

For this challenge, the application was therefore accessible at:

```text
http://stapp02:8087
```

### HTTP Connector

Tomcat's HTTP connector determines the port on which Tomcat accepts HTTP requests.

For this deployment, the connector was configured for:

```text
8087
```

## DevOps Relevance

This task demonstrates several practical DevOps skills:

* Linux server administration
* Application server configuration
* Service management
* Application artifact deployment
* Port configuration
* Log-based troubleshooting
* HTTP endpoint verification
* Infrastructure and application validation

The verification process is particularly important in DevOps because a service being `running` does not necessarily mean the application is accessible. The successful `curl` test confirmed both service availability and application functionality.

## Troubleshooting

During verification, `ss` was unavailable on the server:

```text
ss: command not found
```

This did not prevent successful verification because the Tomcat service logs provided direct evidence that the HTTP connector was initialized on port `8087`.

The application was then validated using:

```bash
curl http://stapp02:8087
```

and:

```bash
curl -I http://stapp02:8087
```

The final HTTP response was:

```text
HTTP/1.1 200
```

## Security Considerations

* Only the required application port should be exposed.
* Application artifacts should come from trusted sources.
* Service accounts should use only the permissions required to run the application.
* Production environments should use HTTPS rather than exposing application traffic over plain HTTP.
* Server logs should be monitored for application and service failures.

## What I Learned

This task strengthened my understanding of deploying and validating Java web applications using Tomcat.

Key lessons included:

* Configuring an application server for a non-default HTTP port
* Deploying a WAR application
* Using service status and logs to troubleshoot application servers
* Understanding the relationship between a WAR file and the Tomcat root context
* Verifying application availability using `curl`
* Distinguishing between service-level health and application-level health

## Commands

The commands used during the implementation and verification are documented in:

[`commands.sh`](./commands.sh)

## Challenge Status

**Completed — Day 11/100** ✅
