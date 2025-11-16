# Hostel Management System - Local Docker Setup

This guide explains how to run the Hostel Management System locally using Docker containers for development.

## Architecture Overview

The application consists of 3 main services:
- **Frontend**: React development server (Port 3000)
- **Backend**: Node.js/Express API with hot reload (Port 4000)
- **Database**: MongoDB (Port 27017)

## Prerequisites

- Docker (version 20.0+)
- Docker Compose (version 2.0+)

## Quick Start

### Local Development (with hot reload)
```bash
# Build and start all services
docker-compose up --build

# Run in background
docker-compose up -d --build

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

## Service Details

### Frontend Container
- **Image**: Custom build (Node.js + Nginx)
- **Port**: 3000 (mapped to host)
- **Features**: 
  - Multi-stage build for optimized size
  - Nginx reverse proxy for API calls
  - Static file caching
  - Security headers

### Backend Container
- **Image**: Custom build (Node.js Alpine)
- **Port**: 4000 (mapped to host)
- **Features**:
  - Production-ready Node.js setup
  - Health checks
  - Non-root user for security

### MongoDB Container
- **Image**: Official MongoDB 7.0
- **Port**: 27017 (mapped to host)
- **Features**:
  - Persistent data storage
  - Custom user creation
  - Database initialization

## Environment Variables

### Backend (.env)
```
PORT=4000
NODE_ENV=production
DATABASE_URL=mongodb://hostel_user:hostel_password@mongodb:27017/hostel?authSource=hostel
JWT_URL=project0f2024
```

### Frontend
- Production: Uses nginx proxy (`/api`)
- Development: Direct connection (`http://localhost:4000`)

## Data Persistence

MongoDB data is persisted using Docker volumes:
- Production: `mongodb_data`
- Development: `mongodb_dev_data`

## Useful Commands

### Build specific service
```bash
docker-compose build backend
docker-compose build frontend
```

### View service logs
```bash
docker-compose logs backend
docker-compose logs frontend
docker-compose logs mongodb
```

### Execute commands in containers
```bash
# Backend container
docker-compose exec backend sh

# MongoDB container
docker-compose exec mongodb mongosh -u root -p rootpassword

# Frontend container
docker-compose exec frontend sh
```

### Reset everything (including data)
```bash
docker-compose down -v
docker-compose up --build
```

## Troubleshooting

### Common Issues

1. **Port conflicts**: Make sure ports 3000, 4000, and 27017 are available
2. **Database connection issues**: Wait for MongoDB to fully start before backend
3. **Frontend API calls failing**: Check nginx proxy configuration

### Health Checks
All services include health checks:
```bash
docker-compose ps  # Shows health status
```

### Logs
Check individual service logs:
```bash
docker-compose logs [service-name]
```

## Development Workflow

1. **Local Development**: Use `docker-compose.dev.yml`
2. **Code Changes**: Automatically detected with hot reload
3. **Database Access**: MongoDB available at `localhost:27017`
4. **API Testing**: Backend available at `localhost:4000`
5. **Frontend**: Available at `localhost:3000`

## Production Deployment

For production deployment:
1. Update environment variables
2. Use `docker-compose.yml` (production)
3. Consider using Docker Swarm or Kubernetes for orchestration
4. Set up proper monitoring and logging

## Security Considerations

- Non-root users in all containers
- Nginx security headers
- MongoDB authentication
- Environment variables for secrets
- Network isolation between services

## Scaling

To scale services:
```bash
docker-compose up --scale backend=2 --scale frontend=2
```

Note: Add load balancer for multiple frontend instances.