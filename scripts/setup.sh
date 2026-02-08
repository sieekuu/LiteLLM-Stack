#!/bin/bash

# =============================================================================
# LiteLLM-Stack Quick Setup Script
# =============================================================================
# This script automates the initial setup of LiteLLM-Stack
# =============================================================================

set -e  # Exit on error

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                  LiteLLM-Stack Setup Script                    ║"
echo "║           Production-Ready AI Infrastructure                    ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Check prerequisites
echo "🔍 Checking prerequisites..."
echo ""

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Please install Docker first."
    echo "   Visit: https://docs.docker.com/get-docker/"
    exit 1
fi
echo "✅ Docker found: $(docker --version)"

# Check Docker Compose
if ! command -v docker compose &> /dev/null; then
    echo "❌ Docker Compose not found. Please install Docker Compose first."
    echo "   Visit: https://docs.docker.com/compose/install/"
    exit 1
fi
echo "✅ Docker Compose found: $(docker compose version)"

# Check OpenSSL
if ! command -v openssl &> /dev/null; then
    echo "⚠️  OpenSSL not found. SSL certificate generation may fail."
    echo "   You can still continue, but HTTPS won't work."
    read -p "   Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    echo "✅ OpenSSL found: $(openssl version)"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Generate SSL certificates
echo "🔐 Generating SSL certificates..."
echo ""

SSL_DIR="${PROJECT_ROOT}/config/nginx/ssl"
mkdir -p "${SSL_DIR}"

if [ -f "${SSL_DIR}/cert.pem" ] && [ -f "${SSL_DIR}/key.pem" ]; then
    echo "⚠️  SSL certificates already exist."
    read -p "   Regenerate them? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        bash "${SCRIPT_DIR}/generate-ssl.sh"
    else
        echo "   Keeping existing certificates."
    fi
else
    bash "${SCRIPT_DIR}/generate-ssl.sh"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Setup environment file
echo "📝 Setting up environment file..."
echo ""

ENV_FILE="${PROJECT_ROOT}/config/litellm/.env"
ENV_EXAMPLE="${PROJECT_ROOT}/.env.example"

if [ -f "${ENV_FILE}" ]; then
    echo "⚠️  Environment file already exists at: config/litellm/.env"
    echo "   Skipping creation."
else
    if [ -f "${ENV_EXAMPLE}" ]; then
        cp "${ENV_EXAMPLE}" "${ENV_FILE}"
        echo "✅ Created config/litellm/.env from template"
        echo ""
        echo "⚠️  IMPORTANT: Edit config/litellm/.env and add your API keys!"
        echo "   Example: nano config/litellm/.env"
    else
        echo "⚠️  .env.example not found. You'll need to create config/litellm/.env manually."
    fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Ask if user wants to start services
echo "🚀 Setup complete!"
echo ""
read -p "Start services now? (Y/n) " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    cd "${PROJECT_ROOT}"
    echo ""
    echo "Starting services with Docker Compose..."
    docker compose up -d
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Waiting for services to start..."
    sleep 5
    
    echo ""
    docker compose ps
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    🎉 Setup Complete! 🎉                       ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "📍 Access your services:"
echo ""
echo "   🌐 Open WebUI (HTTPS):  https://localhost:8443"
echo "   📡 LiteLLM API:          http://localhost:4000"
echo "   📊 LiteLLM Admin UI:     http://localhost:4000/ui"
echo ""
echo "⚠️  SSL Certificate Warning:"
echo "   Your browser will show a security warning for self-signed certificates."
echo "   This is normal - click 'Advanced' and 'Proceed' to continue."
echo "   See docs/SSL_SETUP.md for more information."
echo ""
echo "📚 Next steps:"
echo ""
echo "   1. Open https://localhost:8443 in your browser"
echo "   2. Create an admin account (first user)"
echo "   3. Add your API keys in Settings → Connections"
echo "   4. Start chatting with AI models!"
echo ""
echo "📖 Documentation:"
echo ""
echo "   • Main README:    README.md"
echo "   • SSL Setup:      docs/SSL_SETUP.md"
echo "   • Contributing:   CONTRIBUTING.md"
echo ""
echo "💡 Useful commands:"
echo ""
echo "   • View logs:       docker compose logs -f"
echo "   • Stop services:   docker compose stop"
echo "   • Restart:         docker compose restart"
echo "   • Remove all:      docker compose down -v"
echo ""
echo "❤️  Thank you for using LiteLLM-Stack!"
echo ""
