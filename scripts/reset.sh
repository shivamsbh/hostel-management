#!/bin/bash

# Reset script for Hostel Management System
# This will remove all containers, volumes, and images

echo "⚠️  This will remove all data and rebuild everything from scratch!"
read -p "Are you sure? (y/N): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🧹 Cleaning up everything..."
    
    # Stop and remove all containers and volumes
    docker-compose down -v
    docker-compose -f docker-compose.dev.yml down -v
    
    # Remove all images related to this project
    echo "🗑️  Removing project images..."
    docker images | grep hostel | awk '{print $3}' | xargs -r docker rmi -f
    
    # Remove unused networks
    echo "🌐 Cleaning up networks..."
    docker network prune -f
    
    # Remove unused volumes
    echo "💾 Cleaning up volumes..."
    docker volume prune -f
    
    echo "✅ Cleanup completed!"
    echo "🚀 You can now run './scripts/start.sh' to rebuild everything."
else
    echo "❌ Operation cancelled."
fi