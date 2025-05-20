# Stage 1: Use official Nginx image with specific version tag (Rule 2: Maintain Your Balance)
FROM nginx:1.25.4-alpine

# Maintainer information
LABEL maintainer="demo@example.com"
LABEL version="1.0"
LABEL description="A simple hello-world application served by Nginx, following Windsurf principles."

# Remove default Nginx welcome page and copy our content in a single layer (Rule 3: Ride the Wave Efficiently)
RUN rm -rf /usr/share/nginx/html/*

# Copy the local `app` directory contents into the Nginx HTML directory in the container
COPY ./app/index.html /usr/share/nginx/html/

# Create required directories with proper permissions (Rule 5: Secure Your Gear)
RUN mkdir -p /var/cache/nginx /var/run/nginx && \
    chmod -R 777 /var/cache/nginx /var/run/nginx /usr/share/nginx/html

# Expose only necessary port (Rule 5: Secure Your Gear)
EXPOSE 80

# Command to run Nginx in the foreground when the container starts
# This keeps the container running (Rule 4: Be Agile & Responsive)
CMD ["nginx", "-g", "daemon off;"]
