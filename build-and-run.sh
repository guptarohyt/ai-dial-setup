#!/bin/bash

set -e

echo "🚀 Building and Running AI DIAL with Docker Compose"
echo ""

# Check if .env exists
if [ ! -f .env ]; then
    echo "❌ .env file not found!"
    echo "Please create .env file with your GitHub credentials:"
    echo "  cp .env.example .env"
    echo "  # Edit .env and add your credentials"
    exit 1
fi

# Load environment variables
source .env

# Check required variables
if [ -z "$GPR_USERNAME" ] || [ -z "$GPR_PASSWORD" ]; then
    echo "❌ Missing required environment variables in .env"
    echo "Please set GPR_USERNAME and GPR_PASSWORD"
    exit 1
fi

echo "✅ Environment variables loaded"
echo ""

# Build and start services
echo "📦 Building Docker images and starting services..."
docker compose up -d --build

echo ""
echo "⏳ Waiting for services to be healthy..."
sleep 10

# Check service status
docker compose ps

echo ""
echo "✅ AI DIAL is running!"
echo ""
echo "Access the application:"
echo "  🌐 Chat UI:      http://localhost:3000"
echo "  🔧 Backend API:  http://localhost:8080"
echo "  📊 Redis:        localhost:6379"
echo ""
echo "Useful commands:"
echo "  📋 View logs:    docker compose logs -f"
echo "  🛑 Stop:         docker compose down"
echo "  🔄 Restart:      docker compose restart"
echo ""
