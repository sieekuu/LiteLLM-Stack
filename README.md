# LiteLLM-Stack

<div align="center">

![LiteLLM-Stack Banner](https://via.placeholder.com/1200x300/0066CC/FFFFFF?text=LiteLLM-Stack+%7C+Self-Hosted+AI+Infrastructure)

**Production-ready Docker stack for self-hosted AI infrastructure**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-20.10+-blue.svg)](https://www.docker.com/)
[![LiteLLM](https://img.shields.io/badge/LiteLLM-Latest-green.svg)](https://github.com/BerriAI/litellm)
[![Open WebUI](https://img.shields.io/badge/Open_WebUI-Latest-orange.svg)](https://github.com/open-webui/open-webui)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue.svg)](https://www.postgresql.org/)
[![Nginx](https://img.shields.io/badge/Nginx-Alpine-brightgreen.svg)](https://nginx.org/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

[Features](#-key-features) •
[Installation](#-installation) •
[Usage](#-usage) •
[Documentation](#-documentation) •
[Contributing](#-contributing)

</div>

---

## 📖 About

**LiteLLM-Stack** is a complete, production-ready Docker infrastructure for self-hosting AI services. It combines LiteLLM proxy, Open WebUI interface, PostgreSQL database, and SSL-secured Nginx reverse proxy into a single, easy-to-deploy stack.

Perfect for developers, researchers, and organizations who want full control over their AI infrastructure without vendor lock-in.

## ✨ Key Features

### 🚀 **Unified AI Gateway**
- **LiteLLM Proxy** - Connect to 100+ LLM providers (OpenAI, Anthropic, Google, Azure, local models, and more) through a single unified API
- **Load Balancing** - Distribute requests across multiple models and providers
- **Cost Tracking** - Monitor usage and costs across all providers
- **Caching** - Reduce costs with intelligent response caching

### 🎨 **Modern Web Interface**
- **Open WebUI** - Beautiful, ChatGPT-like interface for interacting with AI models
- **Multi-Model Support** - Switch between different models seamlessly
- **Conversation History** - Save and manage your AI conversations
- **Team Collaboration** - User authentication and role management

### 🔒 **Enterprise-Grade Security**
- **SSL/TLS Encryption** - Automatic HTTPS with self-signed or custom certificates
- **Nginx Reverse Proxy** - Professional-grade reverse proxy with security headers
- **Authentication** - Built-in user authentication and API key management
- **Network Isolation** - Docker network separation for enhanced security

### 📦 **Easy Deployment**
- **One-Command Setup** - Get started in minutes with Docker Compose
- **Persistent Storage** - PostgreSQL database for configuration and history
- **Health Checks** - Automatic monitoring and recovery
- **Zero Configuration** - Sensible defaults that work out of the box

### 🔧 **Developer Friendly**
- **OpenAI-Compatible API** - Drop-in replacement for OpenAI API
- **Detailed Logging** - Debug mode for troubleshooting
- **Extensible Configuration** - YAML-based configuration for easy customization
- **Docker Native** - Container-first architecture

## 📋 Prerequisites

- **Docker** 20.10 or higher
- **Docker Compose** 2.0 or higher  
- **OpenSSL** (for SSL certificate generation)
- **2GB RAM** minimum (4GB recommended)
- **5GB disk space** minimum

## 🚀 Installation

### Quick Start (5 minutes)

```bash
# Clone the repository
git clone https://github.com/yourusername/litellm-stack.git
cd litellm-stack

# Generate SSL certificates
cd scripts
chmod +x generate-ssl.sh
./generate-ssl.sh
cd ..

# Create environment file (optional)
cp .env.example config/litellm/.env
# Edit config/litellm/.env and add your API keys

# Start the stack
docker compose up -d

# Check status
docker compose ps
```

### Accessing Services

After deployment, access your services at:

- **🌐 Open WebUI (HTTPS)**: https://localhost:8443
- **📡 LiteLLM API**: http://localhost:4000
- **📊 LiteLLM Admin UI**: http://localhost:4000/ui

### First-Time Setup

1. **Access Open WebUI** at https://localhost:8443
2. **Accept the SSL warning** (for self-signed certificates)
3. **Create an admin account** (first user becomes admin)
4. **Configure API Keys** in Settings → Connections
5. **Start chatting** with your AI models!

## 💡 Usage

### Adding API Keys

#### Method 1: Through Open WebUI (Recommended)
1. Navigate to **Settings** → **Connections**
2. Add your provider credentials (OpenAI, Anthropic, etc.)
3. Test connection and start using models

#### Method 2: Via Configuration File
Edit `config/litellm/config.yaml`:

```yaml
model_list:
  - model_name: gpt-4
    litellm_params:
      model: gpt-4
      api_key: os.environ/OPENAI_API_KEY

  - model_name: claude-3-sonnet
    litellm_params:
      model: claude-3-sonnet-20240229
      api_key: os.environ/ANTHROPIC_API_KEY
```

Add keys to `config/litellm/.env`:
```bash
OPENAI_API_KEY=sk-your-key-here
ANTHROPIC_API_KEY=sk-ant-your-key-here
```

Restart services:
```bash
docker compose restart litellm
```

### Using the API

The stack exposes an OpenAI-compatible API:

```bash
# Example: Chat completion
curl -X POST http://localhost:4000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk-1234" \
  -d '{
    "model": "gpt-4",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

### Managing Services

```bash
# View logs
docker compose logs -f

# Stop services
docker compose stop

# Start services
docker compose start

# Restart services
docker compose restart

# Remove everything (including volumes)
docker compose down -v
```

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────┐
│                    Client                        │
│              (Browser / API Client)              │
└────────────────────┬────────────────────────────┘
                     │ HTTPS (8443) / HTTP (8080)
                     ▼
┌─────────────────────────────────────────────────┐
│                Nginx Reverse Proxy              │
│          (SSL Termination, Security)            │
└────────────────────┬────────────────────────────┘
                     │
          ┌──────────┴──────────┐
          ▼                     ▼
┌──────────────────┐  ┌──────────────────┐
│   Open WebUI     │  │   LiteLLM Proxy  │
│  (Port 8080)     │  │   (Port 4000)    │
└────────┬─────────┘  └────────┬─────────┘
         │                     │
         └──────────┬──────────┘
                    ▼
         ┌────────────────────┐
         │   PostgreSQL DB    │
         │   (Port 5432)      │
         └────────────────────┘
```

## 📚 Documentation

- **[SSL Setup Guide](docs/SSL_SETUP.md)** - Detailed SSL/TLS configuration
- **[Configuration Reference](config/litellm/config.yaml)** - LiteLLM configuration options
- **[LiteLLM Docs](https://docs.litellm.ai/)** - Official LiteLLM documentation
- **[Open WebUI Docs](https://docs.openwebui.com/)** - Official Open WebUI documentation

## 🔧 Configuration

### Environment Variables

Key environment variables (in docker-compose.yml):

| Variable | Description | Default |
|----------|-------------|---------|
| `LITELLM_MASTER_KEY` | Master API key for LiteLLM | `sk-1z4bxV6OoK` |
| `DATABASE_URL` | PostgreSQL connection string | Auto-configured |
| `POSTGRES_PASSWORD` | PostgreSQL password | `bmFj5xF07m` |
| `WEBUI_AUTH` | Enable Open WebUI authentication | `true` |

### Ports

| Service | Internal Port | External Port | Protocol |
|---------|---------------|---------------|----------|
| Nginx (HTTPS) | 443 | 8443 | HTTPS |
| Nginx (HTTP) | 80 | 8080 | HTTP |
| LiteLLM API | 4000 | 4000 | HTTP |
| PostgreSQL | 5432 | - | Internal |
| Open WebUI | 8080 | - | Internal |

## 🔐 Security Considerations

### For Development/Testing
- Default SSL uses self-signed certificates
- Default passwords should be changed
- Suitable for local development and testing

### For Production
- [ ] Replace self-signed certificates with valid SSL certificates (Let's Encrypt)
- [ ] Change all default passwords and API keys
- [ ] Configure firewall rules
- [ ] Enable additional security headers
- [ ] Set up regular backups
- [ ] Implement rate limiting
- [ ] Use Docker secrets for sensitive data

## 🐛 Troubleshooting

<details>
<summary><b>Services won't start</b></summary>

```bash
# Check Docker daemon is running
docker ps

# Check logs for errors
docker compose logs

# Ensure ports are not in use
netstat -tulpn | grep -E '8080|8443|4000'
```
</details>

<details>
<summary><b>SSL certificate warnings</b></summary>

This is normal for self-signed certificates. See [SSL Setup Guide](docs/SSL_SETUP.md) for:
- How to accept the warning safely
- How to install the certificate in your browser
- How to use Let's Encrypt for production
</details>

<details>
<summary><b>Can't connect to models</b></summary>

1. Verify API keys are correctly set in `config/litellm/.env`
2. Check LiteLLM logs: `docker compose logs litellm`
3. Test API key validity with the provider directly
4. Ensure model names are correct in configuration
</details>

<details>
<summary><b>Database connection errors</b></summary>

```bash
# Wait for PostgreSQL to be ready
docker compose logs postgres

# Check health status
docker compose ps

# Restart database
docker compose restart postgres
```
</details>

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Ways to Contribute
- 🐛 Report bugs
- 💡 Suggest new features
- 📝 Improve documentation
- 🔧 Submit pull requests

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Copyright © 2026 Krzysztof Siek

## 🙏 Acknowledgments

This project builds upon excellent open-source software:

- **[LiteLLM](https://github.com/BerriAI/litellm)** - Unified LLM proxy
- **[Open WebUI](https://github.com/open-webui/open-webui)** - Modern AI interface
- **[PostgreSQL](https://www.postgresql.org/)** - Reliable database
- **[Nginx](https://nginx.org/)** - High-performance web server
- **[Docker](https://www.docker.com/)** - Containerization platform

## 📞 Support

- **Documentation**: Check the [docs](docs/) folder
- **Issues**: Open an issue on [GitHub Issues](https://github.com/yourusername/litellm-stack/issues)
- **Discussions**: Join [GitHub Discussions](https://github.com/yourusername/litellm-stack/discussions)

## ⭐ Star History

If you find this project useful, please consider giving it a star! It helps others discover the project.

---

<div align="center">

**[⬆ Back to Top](#litellm-stack)**

Made with ❤️ by [Krzysztof Siek](https://github.com/sieekuu)

</div>
