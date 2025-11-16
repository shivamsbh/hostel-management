# Local Development Dockerfile for Frontend
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Expose port for React dev server
EXPOSE 3000

# Start development server with hot reload
CMD ["npm", "start"]