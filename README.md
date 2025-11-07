# AI DIAL Setup Guide

This repository contains setup configurations and scripts for running [EPAM's AI DIAL](https://github.com/epam/ai-dial) project.

**Original Projects:**
- 🔧 Backend: [ai-dial-core](https://github.com/epam/ai-dial-core) (Apache 2.0 License)
- 🎨 Frontend: [ai-dial-chat](https://github.com/epam/ai-dial-chat) (Apache 2.0 License)

**This setup repository provides:**
- ✅ Docker configurations for easy deployment
- ✅ Local development setup guides
- ✅ Platform-specific instructions (Mac, Windows, Linux)
- ✅ Integration with Ollama for local models
- ✅ Pre-configured settings for quick start

## 📁 Repository Structure

```
ai-dial-setup/
├── configs/                        # Configuration files
│   ├── aidial.settings.json        # Local backend config
│   ├── aidial.settings.docker.json # Docker backend config
│   ├── aidial.config.json          # Model configurations
│   └── env.local.example           # UI environment template
├── dockerfiles/                    # Docker configurations
│   ├── backend.Dockerfile          # Backend Docker image
│   └── ui.Dockerfile               # UI Docker image
├── docker-compose.yml              # Docker Compose orchestration
├── .env.example                    # Environment variables template
├── setup.sh                        # Setup script (clones EPAM repos)
├── build-and-run.sh                # Quick start script
├── README.md                       # This file
└── DOCKER_README.md                # Detailed Docker documentation

# After running setup.sh:
├── ai-dial-core/                   # EPAM backend (gitignored)
└── ai-dial-chat/                   # EPAM frontend (gitignored)
```

## 🚀 Quick Setup

**First time setup:**

```bash
# 1. Clone this setup repository
git clone https://github.com/YOUR_USERNAME/ai-dial-setup.git
cd ai-dial-setup

# 2. Run setup script (clones EPAM repos and copies configs)
./setup.sh

# 3. Edit .env file with your GitHub credentials
nano .env

# 4. Start with Docker
./build-and-run.sh

# 5. Access the application
open http://localhost:3000
```

## 🚀 Quick Start (After Setup)

### Option 1: Docker (Recommended)

```bash
# Start all services
./build-and-run.sh

# Access the application
open http://localhost:3000
```

### Option 2: Local Development

**Prerequisites:**
- Java 21 installed
- Node.js and npm installed
- Redis installed
- Ollama running (optional, for local models)

**Step 1: Start Redis** (Terminal 1)
```bash
redis-server
```
Keep this terminal running.

**Step 2: Start Backend** (Terminal 2)
```bash
cd ai-dial-core
AIDIAL_SETTINGS=/Users/guptarohyt/workspace/learning/dial/ai-dial-core/aidial.settings.json ./gradlew :server:run
```
Wait until you see "Proxy started on 8080". Keep this terminal running.

**Step 3: Start UI** (Terminal 3)
```bash
cd ai-dial-chat
npm install  # Only needed first time
npm run nx serve chat
```
Wait until you see "✓ Ready". Keep this terminal running.

**Step 4: Access Application**
```bash
open http://localhost:3000
```

**Stop Local Services:**
Press `Ctrl+C` in each terminal to stop the services.

## 🐳 Docker Services

| Service | Container | Port | Description |
|---------|-----------|------|-------------|
| Redis | `dial-redis` | 6379 | Cache & sessions |
| Backend | `dial-core` | 8080 | API server |
| Frontend | `dial-chat` | 3000 | Web UI |

## ⚙️ Configuration

### Models

Edit `ai-dial-core/aidial.config.json`:

```json
{
  "models": {
    "deepseek-r1:14b": {
      "type": "chat",
      "displayName": "DeepSeek R1 14B (Local)",
      "endpoint": "http://host.docker.internal:11434/v1/chat/completions",
      "upstreams": [{
        "endpoint": "http://host.docker.internal:11434/v1"
      }]
    }
  }
}
```

### API Keys

Default API key: `dev-key`

Add more keys in `aidial.config.json`:
```json
{
  "keys": {
    "dev-key": {
      "project": "Development",
      "role": "default"
    }
  }
}
```

## 📊 Available Models

Currently configured:
- ✅ **DeepSeek R1 14B** (Local Ollama) - Working
- ⚠️ Claude 3.5 Sonnet (needs valid Anthropic API key)
- ⚠️ GPT-3.5 Turbo (needs valid OpenAI API key)

## 🔧 Docker Management

### View logs
```bash
docker compose logs -f
```

### Restart services
```bash
docker compose restart
```

### Stop everything
```bash
docker compose down
```

### Clean up (including data)
```bash
docker compose down -v
```

### Update configuration
```bash
# Edit aidial.config.json
vi ai-dial-core/aidial.config.json

# Restart backend (auto-reloads in 60s, or restart immediately)
docker compose restart dial-core
```

## 🛠️ Development

### Rebuild Docker after code changes
```bash
docker compose up -d --build
```

### Access container shells
```bash
# Backend
docker compose exec dial-core sh

# UI
docker compose exec dial-chat sh

# Redis
docker compose exec redis redis-cli
```

## 🔑 Adding API Keys

To add API keys for Claude or OpenAI models:

1. **Get your API keys:**
   - OpenAI: https://platform.openai.com/api-keys
   - Anthropic (Claude): https://console.anthropic.com/settings/keys

2. **Edit `ai-dial-core/aidial.config.json`:**
   ```json
   {
     "models": {
       "gpt-3.5-turbo": {
         "upstreams": [{
           "endpoint": "https://api.openai.com/v1",
           "key": "YOUR_OPENAI_KEY_HERE"
         }]
       }
     }
   }
   ```

3. **Restart backend:**
   - Docker: `docker compose restart dial-core`
   - Local: Restart the backend terminal (Ctrl+C, then rerun)
   - Or wait 60 seconds for auto-reload

## 📝 Environment Variables

Required in `.env`:
- `GPR_USERNAME` - GitHub username
- `GPR_PASSWORD` - GitHub Personal Access Token (read:packages)
- `NEXTAUTH_SECRET` - Random secret for NextAuth

## 🔍 Troubleshooting

### Local Backend Won't Start

**"At least one identity provider is required"**
- Make sure `aidial.settings.json` includes the `identityProviders` section (see file for reference)
- Use absolute path: `AIDIAL_SETTINGS=/full/path/to/aidial.settings.json ./gradlew :server:run`

**Port already in use**
```bash
# Check what's using port 8080
lsof -ti:8080

# Kill the process
kill -9 $(lsof -ti:8080)
```

**Redis connection failed**
```bash
# Check if Redis is running
redis-cli ping  # Should return PONG

# Start Redis if not running
redis-server
```

### Docker Issues

**Backend won't start**
```bash
# Check logs
docker compose logs dial-core

# Verify Redis is running
docker compose ps redis

# Test GitHub credentials
docker compose build dial-core
```

**UI can't connect to backend**
```bash
# Test backend health
curl http://localhost:8080/health

# Check network
docker network inspect dial_dial-network
```

### Ollama Models Not Working

**Local Development:**
- Use `localhost:11434` in `aidial.config.json`
- Make sure Ollama is running: `ollama list`

**Docker:**
- Use `host.docker.internal:11434` in `aidial.config.json`
- Verify connection from container: `docker exec dial-core curl http://host.docker.internal:11434/api/tags`

## 📚 Documentation

- [Docker Setup](DOCKER_README.md) - Detailed Docker documentation
- [Backend README](ai-dial-core/README.md) - DIAL Core documentation  
- [UI README](ai-dial-chat/README.md) - Chat UI documentation

## 🎯 Next Steps

1. ✅ Setup complete - Everything is running
2. ⚠️ Add valid OpenAI or Anthropic API keys (optional)
3. ⚠️ Configure authentication for production
4. ⚠️ Set up HTTPS with reverse proxy
5. ⚠️ Configure external storage (S3, Azure Blob, etc.)

## 🤝 Support

For issues and questions:
- DIAL Core: https://github.com/epam/ai-dial-core
- DIAL Chat: https://github.com/epam/ai-dial-chat
