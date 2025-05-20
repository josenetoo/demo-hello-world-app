# Hello World Docker Application

A simple, Docker-based "hello-world" application that follows Windsurf principles.

## Overview

This project demonstrates a basic containerized web application setup with clear documentation, following best practices. The application serves a "Hello, World!" message through Nginx running in a Docker container.

## Features

- Minimal web application serving a "Hello, World!" message
- Containerized using Docker with Nginx
- Follows Windsurf principles for Docker applications
- Accessible via web browser at `http://localhost:8080`

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
   - Simple configuration

5. **Secure Your Gear (Container Security Best Practices)**
   - Proper permissions management
   - Minimal port exposure

## Getting Started

### Prerequisites

- Docker Desktop (for Mac/Windows) or Docker Engine (for Linux)

### Running the Application

1. Build the Docker image:
   ```bash
   docker build -t hello-world-app:latest .
   ```

2. Run the Docker container:
   ```bash
   docker run -d -p 8080:80 --name my-hello-container hello-world-app:latest
   ```

3. Access the application:
   Open your web browser and navigate to `http://localhost:8080`

### Stopping the Application

```bash
docker stop my-hello-container
docker rm my-hello-container
```

## Project Structure

```
hello-world-app/
├── app/
│   └── index.html         # Simple HTML page with "Hello, World!" message
├── Dockerfile             # Docker configuration file
├── PLANNING.MD            # Project planning documentation
├── TASKS.MD               # Detailed implementation tasks
└── README.md              # This file
```

## License

This project is open source and available under the [MIT License](https://opensource.org/licenses/MIT).
