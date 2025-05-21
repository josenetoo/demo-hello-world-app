# Hello World Docker Application

A simple, Docker-based "hello-world" application that follows Windsurf principles.

## Overview

This project demonstrates a basic containerized web application setup with clear documentation, following best practices. The application serves a "Hello, World!" message through Nginx running in a Docker container. The application now supports dynamic configuration through environment variables and implements multi-stage builds with security enhancements. The project also includes Kubernetes manifests for deploying to a GCP Kubernetes cluster with a Load Balancer.

## Features

- Minimal web application serving a "Hello, World!" message
- Containerized using Docker with Nginx
- Follows Windsurf principles for Docker applications
- Accessible via web browser at `http://localhost:8080`
- Dynamic configuration via environment variables
- Multi-stage build for optimized image size
- Container health monitoring
- Enhanced security with non-root user

## Windsurf Principles Applied

1. **Catch the Right Wind (Use Official & Minimal Base Images)**
   - Uses `nginx:1.25.4-alpine` as the base image for minimal size and security

2. **Maintain Your Balance (Reproducible Builds)**
   - Specific version tags for base images
   - Minimized external dependencies

3. **Ride the Wave Efficiently (Optimize Layers & Build Cache)**
   - Optimized Dockerfile with minimal layers
   - Efficient command ordering

4. **Be Agile & Responsive (Stateless & Configurable Containers)**
   - Stateless container design
   - Dynamic configuration through environment variables
   - Customizable greeting message, colors, and background

5. **Secure Your Gear (Container Security Best Practices)**
   - Proper permissions management
   - Minimal port exposure
   - Non-root user execution
   - Container health monitoring
   - Reduced permissions (755 instead of 777)

## Getting Started

### Prerequisites

- Docker Desktop (for Mac/Windows) or Docker Engine (for Linux)

### Running the Application

1. Build the Docker image:
   ```bash
   docker build -t hello-world-app:latest .
   ```

2. Run the Docker container with default settings:
   ```bash
   docker run -d -p 8080:80 --name my-hello-container hello-world-app:latest
   ```

   Or customize with environment variables:
   ```bash
   docker run -d -p 8080:80 \
     -e GREETING_TEXT="Olá, Mundo!" \
     -e GREETING_COLOR="#0066cc" \
     -e BG_COLOR="#f5f5f5" \
     --name my-hello-container hello-world-app:latest
   ```

3. Access the application:
   Open your web browser and navigate to `http://localhost:8080`

4. Check container health status:
   ```bash
   docker inspect --format='{{.State.Health.Status}}' my-hello-container
   ```

### Stopping the Application

```bash
docker stop my-hello-container
docker rm my-hello-container
```

## Project Structure

```
hello-world-app/
├── app/
│   ├── index.html         # Template HTML page (generated dynamically)
│   └── entrypoint.sh      # Script for dynamic configuration
├── kubernetes/            # Kubernetes deployment manifests
│   ├── namespace.yaml     # Namespace definition
│   ├── configmap.yaml     # Application configuration
│   ├── deployment.yaml    # Pod deployment configuration
│   ├── service.yaml       # LoadBalancer service
│   ├── hpa.yaml           # Horizontal Pod Autoscaler
│   ├── deploy.sh          # Deployment script
│   └── README.md          # Kubernetes-specific documentation
├── Dockerfile             # Docker configuration file with multi-stage build
├── .dockerignore          # Files to exclude from Docker build context
├── PLANNING.MD            # Project planning documentation
├── TASKS.MD               # Detailed implementation tasks
└── README.md              # This file
```

## Deployment Options

### Local Docker Deployment

See the [Getting Started](#getting-started) section for running locally with Docker.

### Kubernetes Deployment

The application can be deployed to a Kubernetes cluster with a GCP Load Balancer:

1. Push the Docker image to DockerHub:
   ```bash
   docker tag hello-world-app:latest josenetoalest/hello-world:v1.1
   docker push josenetoalest/hello-world:v1.1
   ```

2. Deploy to Kubernetes:
   ```bash
   cd kubernetes
   ./deploy.sh
   ```

For detailed Kubernetes deployment instructions, see [kubernetes/README.md](kubernetes/README.md).

### CI/CD Strategy

This project implements a modern CI/CD strategy that separates concerns:

#### CI with GitHub Actions

The Continuous Integration pipeline is implemented with GitHub Actions and automates the following tasks:

1. **Lint**: Validates the Dockerfile using Hadolint
2. **Build and Push**: Builds and pushes the Docker image to DockerHub
   - Creates multi-platform images (linux/amd64, linux/arm64)
   - Uses BuildKit cache for faster builds
3. **Security Scan**: Scans the Docker image for vulnerabilities using Trivy
4. **Notification**: Creates a notification with the new image tag for ArgoCD

##### Required Secrets for CI

To use the CI pipeline, you need to set up the following secrets in your GitHub repository:

- `DOCKERHUB_USERNAME`: Your DockerHub username
- `DOCKERHUB_TOKEN`: Your DockerHub access token

##### Workflow Triggers

The pipeline is triggered on:
- Push to the `main` branch
- Pull requests to the `main` branch
- Manual trigger via GitHub Actions UI

#### CD with ArgoCD

The Continuous Deployment is managed by ArgoCD in the Kubernetes cluster, following the GitOps approach:

1. ArgoCD monitors the Git repository for changes
2. When a new image is built by the CI pipeline, ArgoCD detects the change
3. ArgoCD automatically syncs the application state with the desired state defined in Git
4. The deployment is updated with zero downtime

This separation of CI and CD follows the Windsurf principle of "Maintain Your Balance" by clearly defining responsibilities and using specialized tools for each part of the process.

## License

This project is open source and available under the [MIT License](https://opensource.org/licenses/MIT).
