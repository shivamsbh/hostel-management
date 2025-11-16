# Local Development Dockerfile for Backend
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install nodemon globally for hot reload
RUN npm install -g nodemon

# Copy package.json and package-lock.json
COPY package*.json ./

# Install all dependencies (including dev dependencies for local development)
RUN npm install

# Copy source code
COPY . .

# Expose port
EXPOSE 4000

# Use nodemon for local development with hot reload
CMD ["nodemon", "app.js"]