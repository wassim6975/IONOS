## This is an example of the official NGINX image as the base image
FROM nginx:latest

# Copy custom configuration file from the current directory to NGINX's configuration directory
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 to the outside world
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
