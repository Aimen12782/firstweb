# Use a small Ubuntu image
FROM ubuntu:22.04

# Install nginx to serve HTML
RUN apt update && apt install -y nginx

# Copy your HTML file to nginx folder
COPY index.html /var/www/html/index.html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
