# TASKS.MD

## 1. Project Setup

This document details the tasks required to create, containerize, run the "hello-world" application locally, and deploy it to a Kubernetes cluster.

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

## 9. Enhanced Docker Implementation

### 9.1. Dynamic Configuration via Environment Variables

1. **Create an entrypoint script:**
   Create a file named `entrypoint.sh` inside the `app` directory with the following content:
   ```bash
   #!/bin/sh
   # Script para substituir dinamicamente o conteúdo da mensagem de boas-vindas
   # baseado em variáveis de ambiente (Princípio 4: Be Agile & Responsive)

   # Definir valores padrão caso as variáveis não sejam fornecidas
   GREETING_TEXT=${GREETING_TEXT:-"Hello, World!"}
   GREETING_COLOR=${GREETING_COLOR:-"#333"}
   BG_COLOR=${BG_COLOR:-"#f0f0f0"}

   # Criar o arquivo index.html com os valores das variáveis
   cat > /usr/share/nginx/html/index.html << EOF
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Hello Docker</title>
       <style>
           body { 
               font-family: Arial, sans-serif; 
               display: flex; 
               justify-content: center; 
               align-items: center; 
               height: 100vh; 
               margin: 0; 
               background-color: ${BG_COLOR}; 
               text-align: center; 
           }
           h1 { color: ${GREETING_COLOR}; }
           .container { 
               padding: 20px; 
               border-radius: 8px; 
               background-color: white; 
               box-shadow: 0 4px 6px rgba(0,0,0,0.1); 
           }
           .footer { 
               margin-top: 20px; 
               font-size: 12px; 
               color: #666; 
           }
       </style>
   </head>
   <body>
       <div class="container">
           <h1>${GREETING_TEXT}</h1>
           <p>This is running in a Docker container!</p>
           <div class="footer">Container started at: $(date)</div>
       </div>
   </body>
   </html>
   EOF

   # Executar o comando original do Nginx
   exec "$@"
   ```

2. **Make the script executable:**
   ```bash
   chmod +x app/entrypoint.sh
   ```

### 9.2. Multi-stage Build and Security Enhancements

1. **Update the Dockerfile:**
   Update the Dockerfile to implement multi-stage build, non-root user, and other security enhancements:
   ```dockerfile
   # Stage 1: Use official Nginx image with specific version tag (Rule 2: Maintain Your Balance)
   FROM nginx:1.25.4-alpine AS builder

   # Maintainer information
   LABEL maintainer="demo@example.com"
   LABEL version="1.5"
   LABEL description="A simple hello-world application served by Nginx, following Windsurf principles."

   # Remove default Nginx welcome page (Rule 3: Ride the Wave Efficiently)
   RUN rm -rf /usr/share/nginx/html/*

   # Stage 2: Create a minimal production image (Rule 3: Ride the Wave Efficiently)
   FROM nginx:1.25.4-alpine

   # Copy labels from builder stage
   COPY --from=builder /usr/share/nginx/html /usr/share/nginx/html

   # Copy the entrypoint script and application files
   COPY ./app/entrypoint.sh /entrypoint.sh

   # Create required directories with proper permissions (Rule 5: Secure Your Gear)
   RUN mkdir -p /var/cache/nginx /var/run/nginx /var/cache/nginx/client_temp /var/cache/nginx/proxy_temp /var/cache/nginx/fastcgi_temp /var/cache/nginx/uwsgi_temp /var/cache/nginx/scgi_temp && \
       # Create a non-root user to run Nginx (Rule 5: Secure Your Gear)
       addgroup -S appgroup && adduser -S appuser -G appgroup && \
       # Set proper ownership and permissions for the non-root user
       chown -R appuser:appgroup /var/cache/nginx /var/run/nginx /usr/share/nginx/html && \
       chmod -R 777 /var/cache/nginx /var/run/nginx /usr/share/nginx/html && \
       chmod +x /entrypoint.sh

   # Configure environment variables with defaults (Rule 4: Be Agile & Responsive)
   ENV GREETING_TEXT="Hello, World!"
   ENV GREETING_COLOR="#333"
   ENV BG_COLOR="#f0f0f0"

   # Add healthcheck to ensure container is healthy (Rule 5: Secure Your Gear)
   HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
       CMD wget --no-verbose --tries=1 --spider http://localhost:8080/ || exit 1

   # Modificar a configuração do Nginx para usar a porta 8080 (não privilegiada) e um local personalizado para o PID
   RUN sed -i 's/listen       80/listen       8080/g' /etc/nginx/conf.d/default.conf && \
       # Criar diretório para o arquivo PID com permissões adequadas
       mkdir -p /tmp/nginx && \
       chown -R appuser:appgroup /tmp/nginx && \
       chmod -R 777 /tmp/nginx && \
       # Configurar o Nginx para usar o diretório personalizado para o arquivo PID
       sed -i 's|pid        /var/run/nginx.pid;|pid        /tmp/nginx/nginx.pid;|' /etc/nginx/nginx.conf

   # Expose only necessary port (Rule 5: Secure Your Gear)
   EXPOSE 8080

   # Set the entrypoint to our script and pass the CMD to it
   ENTRYPOINT ["/entrypoint.sh"]

   # Command to run Nginx in the foreground when the container starts
   # This keeps the container running (Rule 4: Be Agile & Responsive)
   CMD ["nginx", "-g", "daemon off;"]
   ```

2. **Build the updated Docker image:**
   ```bash
   docker build -t hello-world-app:v1.5 .
   ```

3. **Run the container with environment variables:**
   ```bash
   docker run -d -p 8080:8080 \
     -e GREETING_TEXT="Hello, Customized World!" \
     -e GREETING_COLOR="#0066cc" \
     -e BG_COLOR="#f5f5f5" \
     --name my-hello-container hello-world-app:v1.5
   ```

## 10. Kubernetes Deployment

### 10.1. Prepare Kubernetes Manifests

1. **Create a directory for Kubernetes manifests:**
   ```bash
   mkdir -p kubernetes
   ```

2. **Create namespace.yaml:**
   ```yaml
   apiVersion: v1
   kind: Namespace
   metadata:
     name: hello-world
     labels:
       name: hello-world
       app: hello-world
   ```

3. **Create configmap.yaml:**
   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: hello-world-config
     namespace: hello-world
   data:
     GREETING_TEXT: "Hello from Kubernetes!"
     GREETING_COLOR: "#0066cc"
     BG_COLOR: "#f8f9fa"
   ```

4. **Create deployment.yaml:**
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: hello-world
     namespace: hello-world
     labels:
       app: hello-world
   spec:
     replicas: 3
     selector:
       matchLabels:
         app: hello-world
     strategy:
       type: RollingUpdate
       rollingUpdate:
         maxSurge: 1
         maxUnavailable: 1
     template:
       metadata:
         labels:
           app: hello-world
       spec:
         containers:
         - name: hello-world
           image: josenetoalest/hello-world:v1.5
           imagePullPolicy: Always
           ports:
           - containerPort: 8080
             name: http
           envFrom:
           - configMapRef:
               name: hello-world-config
           resources:
             limits:
               cpu: "0.2"
               memory: "128Mi"
             requests:
               cpu: "0.1"
               memory: "64Mi"
           livenessProbe:
             httpGet:
               path: /
               port: 8080
             initialDelaySeconds: 10
             periodSeconds: 30
             timeoutSeconds: 3
             failureThreshold: 3
           readinessProbe:
             httpGet:
               path: /
               port: 8080
             initialDelaySeconds: 5
             periodSeconds: 10
         securityContext:
           runAsNonRoot: true
           runAsUser: 1000
           runAsGroup: 1000
           fsGroup: 1000
         # Especificar a arquitetura ARM64 como requisito
         nodeSelector:
           kubernetes.io/arch: arm64
         # Adicionar tolerância para a taint de arquitetura ARM64
         tolerations:
         - key: "kubernetes.io/arch"
           operator: "Equal"
           value: "arm64"
           effect: "NoSchedule"
   ```

5. **Create service.yaml:**
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: hello-world
     namespace: hello-world
     labels:
       app: hello-world
     annotations:
       cloud.google.com/load-balancer-type: "External"
   spec:
     type: LoadBalancer
     ports:
     - port: 80
       targetPort: 8080
       protocol: TCP
       name: http
     selector:
       app: hello-world
   ```

6. **Create hpa.yaml:**
   ```yaml
   apiVersion: autoscaling/v2
   kind: HorizontalPodAutoscaler
   metadata:
     name: hello-world
     namespace: hello-world
   spec:
     scaleTargetRef:
       apiVersion: apps/v1
       kind: Deployment
       name: hello-world
     minReplicas: 3
     maxReplicas: 10
     metrics:
     - type: Resource
       resource:
         name: cpu
         target:
           type: Utilization
           averageUtilization: 70
   ```

7. **Create deploy.sh script:**
   ```bash
   #!/bin/bash
   # Script para fazer deploy da aplicação hello-world no Kubernetes

   echo "Iniciando deploy da aplicação hello-world no Kubernetes..."

   # Aplicar namespace
   echo "Criando namespace..."
   kubectl apply -f namespace.yaml

   # Aplicar ConfigMap
   echo "Aplicando ConfigMap..."
   kubectl apply -f configmap.yaml

   # Aplicar Deployment
   echo "Aplicando Deployment..."
   kubectl apply -f deployment.yaml

   # Aplicar Service (LoadBalancer)
   echo "Aplicando Service (LoadBalancer)..."
   kubectl apply -f service.yaml

   # Aplicar HPA
   echo "Aplicando HorizontalPodAutoscaler..."
   kubectl apply -f hpa.yaml

   # Verificar status do deployment
   echo "Verificando status do deployment..."
   kubectl -n hello-world rollout status deployment/hello-world

   # Obter o IP externo do LoadBalancer (pode levar alguns minutos para ser atribuído)
   echo "Aguardando IP externo do LoadBalancer (pode levar alguns minutos)..."
   kubectl -n hello-world get service hello-world -w
   ```

8. **Make the deploy script executable:**
   ```bash
   chmod +x kubernetes/deploy.sh
   ```

### 10.2. Push Docker Image to DockerHub

1. **Tag the Docker image for DockerHub:**
   ```bash
   docker tag hello-world-app:v1.5 josenetoalest/hello-world:v1.5
   ```

2. **Push the image to DockerHub:**
   ```bash
   docker push josenetoalest/hello-world:v1.5
   ```

### 10.3. Deploy to Kubernetes

1. **Navigate to the kubernetes directory:**
   ```bash
   cd kubernetes
   ```

2. **Run the deploy script:**
   ```bash
   ./deploy.sh
   ```

3. **Access the application:**
   Once the LoadBalancer has an external IP assigned, access the application at that IP address.

### 10.4. Verify Deployment

1. **Check pod status:**
   ```bash
   kubectl get pods -n hello-world
   ```

2. **Check service status:**
   ```bash
   kubectl get service -n hello-world
   ```

3. **Check HPA status:**
   ```bash
   kubectl get hpa -n hello-world
   ```

4. **View pod logs:**
   ```bash
   kubectl logs -n hello-world -l app=hello-world
   ```

This concludes the tasks required to execute the project.