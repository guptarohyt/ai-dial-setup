#!/bin/bash
set -e

echo "🚀 Setting up AI DIAL..."
echo ""

# Check if repos already exist
if [ -d "ai-dial-core" ] || [ -d "ai-dial-chat" ]; then
    echo "⚠️  EPAM repositories already exist. Skipping clone."
else
    echo "📥 Cloning EPAM repositories..."
    git clone https://github.com/epam/ai-dial-core.git
    git clone https://github.com/epam/ai-dial-chat.git
    echo "✅ Repositories cloned"
fi

echo ""
echo "📋 Copying configuration files..."

# Get absolute path for config file
CURRENT_DIR=$(pwd)
CONFIG_FILE_PATH="${CURRENT_DIR}/ai-dial-core/aidial.config.json"

# Copy config files
cp configs/aidial.settings.json ai-dial-core/aidial.settings.json.tmp
cp configs/aidial.settings.docker.json ai-dial-core/
cp configs/aidial.config.json ai-dial-core/

# Substitute the config file path in settings
sed "s|AIDIAL_CONFIG_FILE_PLACEHOLDER|${CONFIG_FILE_PATH}|g" ai-dial-core/aidial.settings.json.tmp > ai-dial-core/aidial.settings.json
rm ai-dial-core/aidial.settings.json.tmp

# Copy Dockerfiles
cp dockerfiles/backend.Dockerfile ai-dial-core/Dockerfile
cp dockerfiles/ui.Dockerfile ai-dial-chat/Dockerfile

# Copy UI environment file
mkdir -p ai-dial-chat/apps/chat
cp configs/env.local.example ai-dial-chat/apps/chat/.env.local

echo "✅ Configuration files copied"
echo ""

# Check for .env file
if [ ! -f ".env" ]; then
    echo "⚠️  .env file not found. Creating from .env.example..."
    cp .env.example .env
    echo "📝 Please edit .env and add your credentials:"
    echo "   - GPR_USERNAME (GitHub username)"
    echo "   - GPR_PASSWORD (GitHub personal access token)"
    echo ""
fi

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Edit .env file with your credentials"
echo "  2. Run: ./build-and-run.sh"
echo "  3. Access: http://localhost:3000"
echo ""
