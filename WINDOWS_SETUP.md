# AI DIAL Setup for Windows Users

This guide provides detailed, step-by-step instructions for setting up AI DIAL on Windows. Choose between **WSL 2.0 (Recommended)** or **Native Windows**.

## 🎯 Which Windows Setup Should I Choose?

### Option 1: WSL 2.0 (Recommended) ⭐

**Pros:**
- ✅ Best Docker performance
- ✅ Native Linux environment
- ✅ Better compatibility with shell scripts
- ✅ Faster builds and container startup
- ✅ Easier debugging

**Cons:**
- ❌ Requires Windows 10 version 2004+ or Windows 11
- ❌ Uses more disk space initially
- ❌ One-time WSL setup required

**Best for:** Developers, anyone wanting best performance

### Option 2: Native Windows (Git Bash)

**Pros:**
- ✅ Works on any Windows version with Docker Desktop
- ✅ Simpler for Windows-only users
- ✅ No need to learn Linux commands

**Cons:**
- ❌ Slower Docker performance
- ❌ Potential line ending issues
- ❌ Less native compatibility with bash scripts

**Best for:** Beginners, quick testing

---

## 📋 Option 1: WSL 2.0 Setup (Recommended)

### Step 1: Install WSL 2

**1. Open PowerShell as Administrator**
- Press `Win + X`
- Select "Windows PowerShell (Admin)" or "Terminal (Admin)"

**2. Install WSL 2 and Ubuntu**
```powershell
# Install WSL with Ubuntu (default)
wsl --install

# Or specify Ubuntu 22.04
wsl --install -d Ubuntu-22.04

# Set WSL 2 as default
wsl --set-default-version 2
```

**3. Restart your computer** when prompted

**4. After restart, Ubuntu will auto-launch and ask you to create a username and password**
- Choose a username (lowercase, no spaces)
- Choose a password (you'll need this for `sudo` commands)
- **Remember these credentials!**

### Step 2: Install Docker Desktop

**1. Download Docker Desktop**
- Visit: https://www.docker.com/products/docker-desktop
- Download "Docker Desktop for Windows"

**2. Install Docker Desktop**
- Run the installer
- **Important:** Enable "Use WSL 2 based engine" during installation
- Complete installation and restart if prompted

**3. Configure WSL Integration**
- Open Docker Desktop
- Go to Settings (gear icon)
- Navigate to Resources → WSL Integration
- Enable integration with your Ubuntu distro
- Click "Apply & Restart"

### Step 3: Setup AI DIAL in WSL

**1. Open Ubuntu terminal**
- Search for "Ubuntu" in Windows Start Menu
- Or type `wsl` in PowerShell/Terminal

**2. Update Ubuntu packages**
```bash
sudo apt update && sudo apt upgrade -y
```

**3. Install Git**
```bash
sudo apt install git -y
git --version  # Verify installation
```

**4. Navigate to your home directory** (important for performance!)
```bash
cd ~
pwd  # Should show /home/your-username
```

**5. Clone the AI DIAL setup repository**
```bash
git clone https://github.com/YOUR_USERNAME/ai-dial-setup.git
cd ai-dial-setup
```

**6. Make scripts executable**
```bash
chmod +x setup.sh build-and-run.sh
```

**7. Run the setup script**
```bash
./setup.sh
```

**8. Create GitHub Personal Access Token**
- Open browser and go to: https://github.com/settings/tokens
- Click "Generate new token (classic)"
- Give it a name: "AI DIAL Setup"
- Select scope: ✅ `read:packages`
- Click "Generate token"
- **Copy the token** (starts with `ghp_...`)

**9. Edit the .env file**
```bash
nano .env
```

Edit the file:
```env
GPR_USERNAME=your-github-username
GPR_PASSWORD=ghp_your_copied_token
NEXTAUTH_SECRET=your-random-secret-here
```

Save and exit:
- Press `Ctrl + O` (WriteOut)
- Press `Enter` (confirm)
- Press `Ctrl + X` (eXit)

**10. Build and run AI DIAL**
```bash
./build-and-run.sh
```

This will take 5-10 minutes for the first build.

**11. Access AI DIAL**
- Open your Windows browser
- Go to: http://localhost:3000
- You should see the AI DIAL chat interface!

### Step 4: Verify Everything Works

```bash
# Check running containers
docker compose ps

# Should show 3 running containers:
# - dial-redis (healthy)
# - dial-core (healthy)
# - dial-chat (up)
```

---

## 📋 Option 2: Native Windows Setup (Git Bash)

### Step 1: Install Prerequisites

**1. Install Docker Desktop**
- Download: https://www.docker.com/products/docker-desktop
- Install and enable WSL 2 backend when prompted
- Restart your computer

**2. Install Git for Windows**
- Download: https://git-scm.com/download/win
- Run installer with default options
- This includes Git Bash

### Step 2: Setup AI DIAL

**1. Open Git Bash**
- Right-click on desktop → "Git Bash Here"
- Or search for "Git Bash" in Start Menu

**2. Navigate to where you want to clone the repo**
```bash
cd /c/Users/YourUsername/Documents/
# Or wherever you prefer
```

**3. Clone the repository**
```bash
git clone https://github.com/YOUR_USERNAME/ai-dial-setup.git
cd ai-dial-setup
```

**4. Fix line endings (important!)**
```bash
# Convert scripts to Unix line endings
git config core.autocrlf false
git rm --cached -r .
git reset --hard
```

**5. Make scripts executable**
```bash
chmod +x setup.sh build-and-run.sh
```

**6. Run setup**
```bash
./setup.sh
```

**7. Create GitHub Personal Access Token**
- Go to: https://github.com/settings/tokens
- Generate new token with `read:packages` scope
- Copy the token

**8. Edit .env file**
```bash
# Option 1: Use Notepad
notepad .env

# Option 2: Use nano (if available)
nano .env

# Option 3: Use any text editor
# Just open .env in your preferred editor
```

Update:
```env
GPR_USERNAME=your-github-username
GPR_PASSWORD=ghp_your_token
```

**9. Build and run**
```bash
./build-and-run.sh
```

**10. Access AI DIAL**
- Open browser
- Go to: http://localhost:3000

---

## 🐳 Managing AI DIAL on Windows

### Start AI DIAL
```bash
# WSL or Git Bash
cd ~/ai-dial-setup  # or your install path
./build-and-run.sh
```

### Stop AI DIAL
```bash
docker compose down
```

### View Logs
```bash
# All services
docker compose logs -f

# Specific service
docker compose logs -f dial-core
```

### Restart Services
```bash
docker compose restart
```

### Update Configuration
```bash
# Edit model config
nano ai-dial-core/aidial.config.json
# or
code ai-dial-core/aidial.config.json

# Restart to apply changes
docker compose restart dial-core
```

---

## 🔧 Windows-Specific Troubleshooting

### WSL 2.0 Issues

**Problem: "WSL 2 installation is incomplete"**
```powershell
# In PowerShell (Admin)
wsl --update
wsl --shutdown
```

**Problem: Docker command not found in WSL**
```bash
# Make sure Docker Desktop WSL integration is enabled
# Docker Desktop → Settings → Resources → WSL Integration
# Enable your distro

# Restart WSL
wsl --shutdown
# Then open WSL again
```

**Problem: Can't access localhost:3000**
```bash
# In WSL, find IP address
hostname -I

# Access via that IP from Windows browser
# Example: http://172.18.0.1:3000
```

**Problem: Slow performance**
```bash
# Make sure you're in Linux filesystem, not /mnt/c/
pwd
# Should show: /home/username/...
# NOT: /mnt/c/Users/...

# If in /mnt/c/, move to home:
cd ~
# Clone repo again here
```

### Native Windows Issues

**Problem: "command not found" or syntax errors**
```bash
# Fix line endings
dos2unix setup.sh build-and-run.sh

# Or reinstall with proper git config
git config --global core.autocrlf true
```

**Problem: Permission denied**
```bash
# In Git Bash
chmod +x setup.sh build-and-run.sh
```

**Problem: Docker Desktop not starting**
- Ensure Hyper-V and WSL 2 are enabled
- Check Windows Firewall isn't blocking Docker
- Try "Quit Docker Desktop" then restart it

**Problem: Port already in use**
```powershell
# In PowerShell
netstat -ano | findstr :3000
netstat -ano | findstr :8080

# Kill process (replace PID with actual process ID)
taskkill /PID <PID> /F
```

---

## 💡 Windows Tips & Best Practices

### File System Performance

**WSL 2.0:**
- ✅ Store code in Linux filesystem: `/home/username/projects/`
- ❌ Avoid Windows filesystem: `/mnt/c/Users/...`
- Performance difference can be 5-10x faster in Linux filesystem

**Native Windows:**
- Use SSD for best performance
- Avoid OneDrive/cloud-synced folders
- Disable antivirus scanning for project folder (if safe)

### Accessing WSL Files from Windows

**From File Explorer:**
```
\\wsl$\Ubuntu-22.04\home\username\ai-dial-setup
```

**From VS Code:**
- Install "Remote - WSL" extension
- Open WSL terminal
- Run: `code .`

### Using Ollama on Windows

**Option 1: Ollama in WSL**
```bash
# In WSL
curl -fsSL https://ollama.com/install.sh | sh
ollama serve &
ollama pull deepseek-r1:14b
```

**Option 2: Ollama on Windows**
- Download from: https://ollama.com/download/windows
- Install and run
- In `aidial.config.json`, use:
  ```json
  "endpoint": "http://host.docker.internal:11434/v1/chat/completions"
  ```

### Windows Terminal Tips

**Install Windows Terminal** (recommended)
- Download from Microsoft Store
- Better than Git Bash or PowerShell
- Supports tabs and split panes
- Can open WSL, PowerShell, CMD in tabs

**Set WSL as default:**
- Settings → Startup → Default profile → Ubuntu

---

## 📊 Performance Comparison

| Metric | WSL 2.0 | Native Windows |
|--------|---------|----------------|
| **Build Time** | ~100s | ~140s |
| **Startup Time** | ~10s | ~15s |
| **File Operations** | Fast | Moderate |
| **Hot Reload** | Good | Slow |
| **Resource Usage** | Lower | Higher |

---

## 🆘 Getting Help

**Check service status:**
```bash
docker compose ps
docker compose logs
```

**Verify Docker:**
```bash
docker --version
docker compose version
```

**WSL specific:**
```powershell
# In PowerShell
wsl --list --verbose
wsl --status
```

**Complete reset:**
```bash
# Stop everything
docker compose down -v

# Remove all containers and images (careful!)
docker system prune -a --volumes

# Start fresh
./build-and-run.sh
```

---

## 🎯 Next Steps

Once AI DIAL is running:

1. **Add API Keys** (optional)
   - Edit `ai-dial-core/aidial.config.json`
   - Add OpenAI or Anthropic API keys
   - Restart: `docker compose restart dial-core`

2. **Configure Models**
   - Edit model settings in config file
   - Add custom models
   - Configure rate limits

3. **Production Setup**
   - Enable authentication
   - Use external Redis
   - Set up HTTPS
   - Configure proper storage

4. **Development**
   - Install VS Code with Remote WSL extension
   - Set up hot reload for development
   - Configure debugging

---

**Need more help?** Check:
- Main README: [README.md](README.md)
- Docker guide: [DOCKER_README.md](DOCKER_README.md)
- EPAM AI DIAL: https://github.com/epam/ai-dial
