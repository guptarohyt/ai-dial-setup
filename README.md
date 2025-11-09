# AI DIAL Setup Guide

This repository contains setup configurations and scripts for running [EPAM's AI DIAL](https://github.com/epam/ai-dial) project on **Mac, Windows, and Linux (WSL 2.0)**.

**Original Projects:**
- 🔧 Backend: [ai-dial-core](https://github.com/epam/ai-dial-core) (Apache 2.0 License)
- 🎨 Frontend: [ai-dial-chat](https://github.com/epam/ai-dial-chat) (Apache 2.0 License)

**This setup repository provides:**
- ✅ Docker configurations for easy deployment
- ✅ Cross-platform support (Mac, Windows, WSL 2.0)
- ✅ Automated setup scripts
- ✅ Integration with Ollama for local models
- ✅ Pre-configured settings for quick start

**Supported Platforms:**
- 🍎 **macOS** (Intel & Apple Silicon)
- 🪟 **Windows** (Native with Docker Desktop)
- 🐧 **Windows with WSL 2.0** (Ubuntu/Debian recommended)

## 🚀 Quick Navigation

**Choose your setup guide:**
- [🍎 macOS Users](#-quick-setup) - Use the quick setup below
- [🪟 Windows Users](WINDOWS_SETUP.md) - **Detailed Windows guide with screenshots**
- [🐧 WSL 2.0 Users](WINDOWS_SETUP.md#-option-1-wsl-20-setup-recommended) - **Best for Windows users**
- [🐳 Docker Guide](DOCKER_README.md) - Detailed Docker documentation
- [💡 Which Setup?](#-which-setup-should-i-use) - Help me choose

**Common tasks:**
- [Prerequisites](#-prerequisites) - What you need installed
- [Troubleshooting](#-troubleshooting) - Fix common issues
- [Model Configuration](#%EF%B8%8F-configuration) - Add models and API keys
- [Local Development](#option-2-local-development-advanced) - Run without Docker

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
├── README.md                       # Main documentation (this file)
├── DOCKER_README.md                # Detailed Docker documentation
└── WINDOWS_SETUP.md                # Windows-specific setup guide

# After running setup.sh:
├── ai-dial-core/                   # EPAM backend (gitignored)
└── ai-dial-chat/                   # EPAM frontend (gitignored)
```

## 📋 Prerequisites

Choose your platform and follow the corresponding prerequisites:

### 🍎 macOS (Intel & Apple Silicon)

**Required:**
1. **Docker Desktop** (v20.10+)
   - Download: https://www.docker.com/products/docker-desktop
   - Install and start Docker Desktop
   - Enable Docker Compose V2 in Settings

2. **Git**
   ```bash
   # Check if installed
   git --version

   # Install if needed (via Homebrew)
   brew install git
   ```

3. **GitHub Personal Access Token** (read:packages)
   - Create at: https://github.com/settings/tokens
   - Select: `read:packages` scope
   - Copy token (starts with `ghp_...`)

**Optional:**
- **Ollama** (for local models)
  ```bash
  # Install via Homebrew
  brew install ollama

  # Start Ollama service
  ollama serve

  # Pull a model (e.g., DeepSeek R1 14B)
  ollama pull deepseek-r1:14b
  ```

### 🪟 Windows (Native with Docker Desktop)

**Required:**
1. **Docker Desktop for Windows** (v20.10+)
   - Download: https://www.docker.com/products/docker-desktop
   - Install and start Docker Desktop
   - Enable WSL 2 backend in Settings → General
   - Enable Docker Compose V2

2. **Git for Windows**
   - Download: https://git-scm.com/download/win
   - Install with default options
   - Use Git Bash for running scripts

3. **GitHub Personal Access Token** (read:packages)
   - Create at: https://github.com/settings/tokens
   - Select: `read:packages` scope
   - Copy token (starts with `ghp_...`)

**Setup Steps:**
1. Open **Git Bash** (not PowerShell or CMD)
2. Follow the Quick Setup instructions below

**Optional:**
- **Ollama for Windows**
  - Download: https://ollama.com/download/windows
  - Install and start Ollama
  - Pull models: `ollama pull deepseek-r1:14b`

### 🐧 Windows with WSL 2.0 (Recommended for Windows Users)

**Required:**
1. **WSL 2** with Ubuntu or Debian
   ```powershell
   # In PowerShell (as Administrator)
   wsl --install
   wsl --set-default-version 2

   # Install Ubuntu
   wsl --install -d Ubuntu-22.04
   ```

2. **Docker Desktop for Windows** with WSL 2 backend
   - Download: https://www.docker.com/products/docker-desktop
   - Install and enable "Use WSL 2 based engine"
   - Enable integration with your WSL distro in Settings → Resources → WSL Integration

3. **Git** (inside WSL)
   ```bash
   # Inside WSL Ubuntu terminal
   sudo apt update
   sudo apt install git -y
   ```

4. **GitHub Personal Access Token** (read:packages)
   - Create at: https://github.com/settings/tokens
   - Select: `read:packages` scope
   - Copy token (starts with `ghp_...`)

**Setup Steps:**
1. Open **WSL Ubuntu** terminal
2. Clone the repository in your Linux home directory (not /mnt/c/)
   ```bash
   cd ~
   # Then follow Quick Setup instructions below
   ```

**Important WSL Notes:**
- ✅ Clone repo in Linux filesystem (`~/` or `/home/username/`)
- ❌ Avoid Windows filesystem (`/mnt/c/...`) - much slower for Docker
- Docker Desktop must be running on Windows
- Access via `http://localhost:3000` (works from both WSL and Windows)

**Optional:**
- **Ollama in WSL**
  ```bash
  # Install Ollama in WSL
  curl -fsSL https://ollama.com/install.sh | sh

  # Start Ollama
  ollama serve &

  # Pull a model
  ollama pull deepseek-r1:14b
  ```

## 💡 Which Setup Should I Use?

**Quick Recommendation:**
- **Windows Users:** Use WSL 2.0 (best performance and compatibility)
- **Mac Users:** Use Docker Desktop (native performance)
- **Already have WSL?** Use WSL 2.0
- **Want simplest setup?** Use Docker (all platforms)

**Comparison:**

| Feature | Docker (All Platforms) | Local Dev (Advanced) |
|---------|------------------------|----------------------|
| **Setup Time** | 5-10 minutes | 15-30 minutes |
| **Complexity** | ⭐ Easy | ⭐⭐⭐ Advanced |
| **Isolation** | ✅ Complete | ❌ None |
| **Performance** | ⭐⭐⭐ Good | ⭐⭐⭐⭐ Excellent |
| **Debugging** | ⭐⭐ Moderate | ⭐⭐⭐⭐ Easy |
| **Hot Reload** | ❌ Requires rebuild | ✅ Yes |
| **Disk Space** | ~5GB | ~2GB |
| **Best For** | Production-like testing | Active development |

**Platform Performance Notes:**
- **WSL 2.0**: Use Linux filesystem (`~/.../`), not Windows (`/mnt/c/...`) for best Docker performance
- **Windows Native**: Slightly slower than WSL 2.0, but easier for beginners
- **macOS**: Excellent performance on Apple Silicon, good on Intel

## 🚀 Quick Setup

**Works on all platforms (Mac, Windows Git Bash, WSL 2.0):**

```bash
# 1. Clone this setup repository
git clone https://github.com/YOUR_USERNAME/ai-dial-setup.git
cd ai-dial-setup

# 2. Run setup script (clones EPAM repos and copies configs)
chmod +x setup.sh build-and-run.sh  # Make scripts executable
./setup.sh

# 3. Edit .env file with your GitHub credentials
# Choose your editor:
nano .env           # Terminal editor (Mac/Linux/WSL)
vi .env             # Vim editor (all platforms)
code .env           # VS Code (if installed)
notepad .env        # Windows Notepad (Git Bash)

# Add your credentials:
# GPR_USERNAME=your-github-username
# GPR_PASSWORD=ghp_your_personal_access_token

# 4. Start with Docker
./build-and-run.sh

# 5. Access the application
# macOS/Linux:
open http://localhost:3000

# Windows (all):
# Open http://localhost:3000 in your browser
```

## 🚀 Quick Start (After Setup)

### Option 1: Docker (Recommended)

```bash
# Start all services
./build-and-run.sh

# Access the application
open http://localhost:3000
```

### Option 2: Local Development (Advanced)

**Prerequisites:**
- Java 21 JDK installed
- Node.js (v18+) and npm installed
- Redis installed and running
- Ollama running (optional, for local models)

**Installation guides:**

**macOS:**
```bash
# Install via Homebrew
brew install openjdk@21 node redis

# Link Java 21
sudo ln -sfn $(brew --prefix openjdk@21)/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-21.jdk
```

**Windows (via Chocolatey):**
```powershell
# In PowerShell (as Administrator)
choco install openjdk21 nodejs redis-64
```

**WSL/Linux (Ubuntu/Debian):**
```bash
# Install Java 21
sudo apt update
sudo apt install openjdk-21-jdk nodejs npm redis-server -y
```

**Step 1: Start Redis** (Terminal 1)
```bash
# macOS/Linux
redis-server

# Windows (if installed natively)
redis-server.exe

# Or use Docker Redis
docker run -d -p 6379:6379 redis:7-alpine
```
Keep this terminal running.

**Step 2: Start Backend** (Terminal 2)
```bash
cd ai-dial-core

# The setup.sh script already set the correct path
# Just run the server
./gradlew :server:run
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
Open http://localhost:3000 in your browser

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

### Platform-Specific Issues

#### 🍎 macOS Issues

**Port already in use**
```bash
# Check what's using port 8080
lsof -ti:8080

# Kill the process
kill -9 $(lsof -ti:8080)
```

**Docker Desktop not starting**
- Check that virtualization is enabled in BIOS
- Ensure sufficient disk space (at least 20GB free)
- Try resetting Docker Desktop: Preferences → Troubleshoot → Reset to factory defaults

**Ollama on Apple Silicon**
- Ollama works natively on M1/M2/M3 Macs
- Models run faster on Apple Silicon
- Use `host.docker.internal:11434` for Docker containers

#### 🪟 Windows (Native) Issues

**Line ending errors in scripts**
```bash
# If you get "command not found" or syntax errors
# Convert line endings to Unix format (in Git Bash):
dos2unix setup.sh build-and-run.sh

# Or configure git to handle line endings:
git config --global core.autocrlf true
```

**Docker Desktop WSL 2 backend not available**
```powershell
# In PowerShell (as Administrator)
# Enable WSL 2
wsl --install
wsl --set-default-version 2

# Restart Docker Desktop
```

**Permission denied on scripts**
```bash
# In Git Bash
chmod +x setup.sh build-and-run.sh
```

**Cannot connect to localhost:3000**
- Ensure Docker Desktop is running
- Check Windows Firewall isn't blocking port 3000
- Try accessing via `127.0.0.1:3000` instead

#### 🐧 WSL 2.0 Issues

**Docker command not found**
```bash
# Make sure Docker Desktop has WSL integration enabled
# In Docker Desktop: Settings → Resources → WSL Integration
# Enable your distro (e.g., Ubuntu-22.04)

# Restart WSL
wsl --shutdown
# Then reopen WSL terminal
```

**Slow performance**
```bash
# Make sure you're in Linux filesystem, not /mnt/c/
pwd  # Should show /home/username/... NOT /mnt/c/...

# If in /mnt/c/, move to home directory:
cd ~
# Clone the repo again in this location
```

**Cannot access localhost:3000 from Windows browser**
- Ensure WSL and Windows can communicate
- Try accessing via WSL's IP address:
  ```bash
  # In WSL, get IP address
  hostname -I
  # Access via http://<WSL_IP>:3000 from Windows
  ```
- Or use `localhost:3000` (should work if Docker Desktop WSL integration is enabled)

**Ollama port conflicts**
```bash
# If Ollama is running on both Windows and WSL
# Choose one location:

# Option 1: Use Ollama in WSL only
ollama serve  # In WSL

# Option 2: Use Ollama on Windows
# Stop WSL Ollama, use host.docker.internal:11434
```

### Common Issues (All Platforms)

**"At least one identity provider is required"**
- Make sure `aidial.settings.json` includes the `identityProviders` section
- Verify config file path in settings

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
docker network inspect ai-dial-setup_dial-network
```

**Build fails with GitHub authentication error**
- Verify your GitHub Personal Access Token is correct
- Token must have `read:packages` scope
- Check `.env` file has correct `GPR_USERNAME` and `GPR_PASSWORD`
- Try regenerating the token

**Redis connection failed**
```bash
# Check Redis container
docker compose ps redis

# View Redis logs
docker compose logs redis

# Restart Redis
docker compose restart redis
```

### Ollama Integration Issues

**Local Development:**
- Use `localhost:11434` in `aidial.config.json`
- Make sure Ollama is running: `ollama list`
- Test connection: `curl http://localhost:11434/api/tags`

**Docker (all platforms):**
- Use `host.docker.internal:11434` in `aidial.config.json`
- Verify Ollama is running on host machine
- Test from container: `docker exec dial-core curl http://host.docker.internal:11434/api/tags`

**Linux/WSL specific:**
- On pure Linux (not WSL), `host.docker.internal` might not work
- Use host machine's IP address instead:
  ```bash
  # Get host IP
  ip addr show docker0 | grep inet
  # Use this IP in aidial.config.json
  ```

### Getting Help

**Check logs for detailed errors:**
```bash
# All services
docker compose logs -f

# Specific service
docker compose logs -f dial-core
docker compose logs -f dial-chat
docker compose logs -f redis
```

**Verify service health:**
```bash
docker compose ps
curl http://localhost:8080/health  # Backend
curl http://localhost:3000          # Frontend
```

**Complete reset:**
```bash
# Stop and remove everything
docker compose down -v

# Clean Docker system (careful - removes all unused Docker resources)
docker system prune -a --volumes

# Start fresh
./build-and-run.sh
```

## 📚 Documentation

**Setup Guides:**
- [Main README](README.md) - This file (quick start for all platforms)
- [Windows Setup Guide](WINDOWS_SETUP.md) - Detailed Windows & WSL 2.0 guide
- [Docker Setup](DOCKER_README.md) - Detailed Docker documentation

**EPAM AI DIAL Documentation:**
- [Backend Docs](ai-dial-core/README.md) - DIAL Core documentation
- [Frontend Docs](ai-dial-chat/README.md) - Chat UI documentation
- [EPAM AI DIAL GitHub](https://github.com/epam/ai-dial) - Official repository

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
