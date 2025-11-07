# AI DIAL Docker Deployment

This guide explains how to run AI DIAL (backend + UI) using Docker Compose.

## Architecture

The deployment consists of 3 services:
1. **Redis** - Caching and session storage
2. **DIAL Core** - Backend API server (Java 21)
3. **DIAL Chat** - Frontend UI (Next.js)

## Prerequisites

- Docker (v20.10+)
- Docker Compose (v2.0+)
- GitHub Personal Access Token with `read:packages` permission

## Quick Start

### 1. Set up environment variables

```bash
# Copy the example environment file
cp .env.example .env

# Edit .env and add your credentials
vi .env
```

Required variables:
```env
GPR_USERNAME=your-github-username
GPR_PASSWORD=ghp_your_github_token
```

### 2. Build and start all services

```bash
# Build images and start containers
docker-compose up -d --build

# View logs
docker-compose logs -f
```

### 3. Access the application

- **Chat UI**: http://localhost:3000
- **Backend API**: http://localhost:8080
- **Redis**: localhost:6379

## Configuration

### Backend Configuration

Edit `ai-dial-core/aidial.config.json` to configure models:

```json
{
  "models": {
    "deepseek-r1:14b": {
      "type": "chat",
      "displayName": "DeepSeek R1 14B (Local)",
      "endpoint": "http://host.docker.internal:11434/v1/chat/completions",
      "upstreams": [
        {
          "endpoint": "http://host.docker.internal:11434/v1"
        }
      ]
    }
  }
}
```

**Note**: To use Ollama from Docker, use `host.docker.internal` instead of `localhost`.

### Static Settings

Edit `ai-dial-core/aidial.settings.json` for server configuration (Redis, storage, auth).

## Docker Commands

### Start services
```bash
docker-compose up -d
```

### Stop services
```bash
docker-compose down
```

### View logs
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f dial-core
docker-compose logs -f dial-chat
```

### Rebuild after code changes
```bash
docker-compose up -d --build
```

### Clean up everything (including volumes)
```bash
docker-compose down -v
```

## Volumes

Data is persisted in Docker volumes:
- `redis-data` - Redis data
- `dial-data` - DIAL Core data (conversations, files, etc.)

## Using Ollama Models

If you have Ollama running on your host machine:

1. **Update aidial.config.json**:
   ```json
   "endpoint": "http://host.docker.internal:11434/v1/chat/completions"
   ```

2. **On Linux**, add to docker-compose.yml under `dial-core`:
   ```yaml
   extra_hosts:
     - "host.docker.internal:host-gateway"
   ```

## Troubleshooting

### Backend fails to start
- Check GitHub credentials in `.env`
- Check logs: `docker-compose logs dial-core`
- Verify Redis is healthy: `docker-compose ps`

### UI can't connect to backend
- Ensure backend is healthy: `curl http://localhost:8080/health`
- Check network: `docker network inspect dial_dial-network`

### Configuration not updating
- Restart backend: `docker-compose restart dial-core`
- Check if file is mounted: `docker-compose exec dial-core cat /app/config/aidial.config.json`

## Ports

| Service | Internal Port | External Port |
|---------|--------------|---------------|
| Redis | 6379 | 6379 |
| DIAL Core | 8080 | 8080 |
| DIAL Chat | 3000 | 3000 |

## Health Checks

All services have health checks:
```bash
# Check service status
docker-compose ps

# Backend health
curl http://localhost:8080/health

# Redis health
docker-compose exec redis redis-cli ping
```

## Production Considerations

1. **Change default secrets** in `.env`
2. **Enable authentication** in `aidial.settings.json`
3. **Use external Redis** for better persistence
4. **Set up reverse proxy** (nginx) for HTTPS
5. **Configure proper storage** (S3, Azure Blob, etc.)
6. **Set resource limits** in docker-compose.yml:
   ```yaml
   deploy:
     resources:
       limits:
         cpus: '2'
         memory: 4G
   ```

## Updating

```bash
# Pull latest changes
cd ai-dial-core && git pull && cd ..
cd ai-dial-chat && git pull && cd ..

# Rebuild and restart
docker-compose up -d --build
```
