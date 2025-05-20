# TASKS.MD

## 1. Project Setup

This document details the tasks required to create, containerize, and run the "hello-world" application locally.

### 1.1. Prerequisites

* **Install Docker:** Ensure Docker Desktop (for Mac/Windows) or Docker Engine (for Linux) is installed and running.
    * [Docker Installation Guide](https://docs.docker.com/get-docker/)
* **Text Editor:** Any text editor (e.g., VS Code, Sublime Text, Notepad++, Vim) for creating the `Dockerfile` and `index.html`.
* **Terminal/Command Prompt:** For running Docker commands.

### 1.2. Project Directory Structure

Create a root directory for the project (e.g., `hello-docker`). Inside this directory, create the following structure:


hello-docker/
├── app/
│   └── index.html
├── Dockerfile
├── PLANNING.MD
├── TASKS.MD        (This file)
└── GOLDEN_RULES.MD


## 2. Application Development (Simple HTML)

1.  **Navigate to the `app` directory:**
    If you haven't created the `hello-docker` directory and `app` subdirectory yet, do so now.
    ```bash
    mkdir -p hello-docker/app
    cd hello-docker/app
    ```
2.  **Create `index.html`:**
    Create a file named `index.html` inside the `app` directory with the following content:
    ```html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hello Docker</title>
        <style>
            body { font-family: Arial, sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; background-color: #f0f0f0; text-align: center; }
            h1 { color: #333; }
        </style>
    </head>
    <body>
        <h1>Hello, World! This is running in a Docker container!</h1>
    </body>
    </html>
    ```
3.  **Navigate back to the project root directory:**
    ```bash
    cd ..
    ```
    (You should now be in the `hello-docker` directory).

## 3. Dockerfile Creation

1.  **Create `Dockerfile`:**
    In the project root directory (`hello-docker/`), create a file named `Dockerfile` (no extension) with the following content:

    ```dockerfile
    # Stage 1: Use official Nginx image from Docker Hub as a parent image
    FROM nginx:alpine

    # Maintainer information (optional, but good practice)
    LABEL maintainer="your.email@example.com"
    LABEL version="1.0"
    LABEL description="A simple hello-world application served by Nginx."

    # Remove default Nginx welcome page and any other existing content
    RUN rm -rf /usr/share/nginx/html/*

    # Copy the local `app` directory contents (specifically index.html) into the Nginx HTML directory in the container
    COPY ./app/index.html /usr/share/nginx/html/

    # Expose port 80 (Nginx default HTTP port)
    EXPOSE 80

    # Command to run Nginx in the foreground when the container starts
    # This keeps the container running
    CMD ["nginx", "-g", "daemon off;"]
    ```

## 4. Building the Docker Image

1.  **Open your terminal or command prompt.**
2.  **Navigate to the project root directory (`hello-docker/`).**
    Make sure you are in the directory that contains your `Dockerfile` and the `app` folder.
    ```bash
    # Example: cd path/to/your/hello-docker
    ```
3.  **Build the Docker image:**
    Execute the following command. Replace `hello-world-app` with your desired image name and tag (e.g., `my-hello-app:latest`). The `.` indicates that the build context is the current directory.

    ```bash
    docker build -t hello-world-app:latest .
    ```
4.  **Verify image creation:**
    List the Docker images to see your newly created image.
    ```bash
    docker images
    ```
    You should see `hello-world-app` with the tag `latest` in the list.

## 5. Running the Docker Container

1.  **Run the Docker container from the image:**
    Execute the following command to start a container. This command maps port `8080` on your host machine to port `80` inside the container (where Nginx is listening). You can choose a different host port if `8080` is already in use (e.g., `8888:80`).

    ```bash
    docker run -d -p 8080:80 --name my-hello-container hello-world-app:latest
    ```
    * `-d`: Runs the container in detached mode (in the background).
    * `-p 8080:80`: Maps host port `8080` to container port `80`.
    * `--name my-hello-container`: Assigns a name to your container for easier management.
    * `hello-world-app:latest`: Specifies the image to use.

2.  **Verify container is running:**
    List the running Docker containers.
    ```bash
    docker ps
    ```
    You should see `my-hello-container` in the list, with port mapping like `0.0.0.0:8080->80/tcp`.

## 6. Accessing the Application

1.  **Open your web browser.**
2.  **Navigate to `http://localhost:8080`** (or `http://localhost:<your_chosen_host_port>` if you used a different port).

    You should see the "Hello, World! This is running in a Docker container!" message displayed.

## 7. Managing the Container (Optional Commands)

* **View container logs:**
    ```bash
    docker logs my-hello-container
    ```
* **Stop the container:**
    ```bash
    docker stop my-hello-container
    ```
* **Start a stopped container:**
    ```bash
    docker start my-hello-container
    ```
* **Remove the container (must be stopped first):**
    ```bash
    docker rm my-hello-container
    ```
* **Remove the Docker image (no containers using it must exist or be stopped & removed):**
    ```bash
    docker rmi hello-world-app:latest
    ```

## 8. Clean Up (Optional)

To stop and remove the container, and then remove the image:

1.  **Stop the container:**
    ```bash
    docker stop my-hello-container
    ```
2.  **Remove the container:**
    ```bash
    docker rm my-hello-container
    ```
3.  **Remove the image:**
    ```bash
    docker rmi hello-world-app:latest
    ```

This concludes the tasks required to execute the project.