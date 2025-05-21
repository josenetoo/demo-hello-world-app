# Stage 1: Use official Nginx image with specific version tag (Rule 2: Maintain Your Balance)
FROM nginx:1.25.4-alpine AS builder

# Maintainer information
LABEL maintainer="demo@example.com"
LABEL version="1.1"
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
