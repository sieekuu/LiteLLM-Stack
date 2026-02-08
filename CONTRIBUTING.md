# Contributing to LiteLLM-Stack

First off, thank you for considering contributing to LiteLLM-Stack! It's people like you that make this project better for everyone.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)
- [Community](#community)

## 📜 Code of Conduct

This project and everyone participating in it is governed by our commitment to providing a welcoming and inclusive environment. By participating, you are expected to uphold this code.

### Our Standards

**Positive behavior includes:**
- Using welcoming and inclusive language
- Being respectful of differing viewpoints and experiences
- Gracefully accepting constructive criticism
- Focusing on what is best for the community
- Showing empathy towards other community members

**Unacceptable behavior includes:**
- Trolling, insulting/derogatory comments, and personal or political attacks
- Public or private harassment
- Publishing others' private information without explicit permission
- Other conduct which could reasonably be considered inappropriate

## 🤝 How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

**Bug Report Template:**
```markdown
**Description:**
A clear and concise description of what the bug is.

**To Reproduce:**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected Behavior:**
A clear description of what you expected to happen.

**Environment:**
- OS: [e.g., Ubuntu 22.04, Windows 11, macOS 13]
- Docker Version: [e.g., 20.10.21]
- Docker Compose Version: [e.g., 2.13.0]
- Browser: [e.g., Chrome 120, Firefox 121]

**Logs:**
```
Paste relevant logs here
```

**Screenshots:**
If applicable, add screenshots to help explain your problem.

**Additional Context:**
Add any other context about the problem here.
```

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

**Enhancement Template:**
```markdown
**Is your feature request related to a problem?**
A clear description of what the problem is. Ex. I'm always frustrated when [...]

**Describe the solution you'd like:**
A clear and concise description of what you want to happen.

**Describe alternatives you've considered:**
A clear description of any alternative solutions or features you've considered.

**Additional context:**
Add any other context, mockups, or screenshots about the feature request here.
```

### Your First Code Contribution

Unsure where to begin? You can start by looking through issues labeled:
- `good first issue` - Issues that should only require a few lines of code
- `help wanted` - Issues that may be more involved but are still great for newcomers

### Documentation Improvements

Documentation is just as important as code! If you find:
- Typos or grammatical errors
- Confusing explanations
- Missing documentation
- Outdated information

Please submit a pull request or create an issue.

## 🛠️ Development Setup

### Prerequisites

- Docker 20.10+
- Docker Compose 2.0+
- Git
- A GitHub account
- A text editor (VS Code recommended)

### Setup Steps

1. **Fork the repository**
   ```bash
   # Click the "Fork" button on GitHub
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/litellm-stack.git
   cd litellm-stack
   ```

3. **Add upstream remote**
   ```bash
   git remote add upstream https://github.com/original-owner/litellm-stack.git
   ```

4. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

5. **Generate SSL certificates (for testing)**
   ```bash
   cd scripts
   chmod +x generate-ssl.sh
   ./generate-ssl.sh
   cd ..
   ```

6. **Create environment file**
   ```bash
   cp .env.example config/litellm/.env
   # Edit config/litellm/.env with your test API keys
   ```

7. **Start the development environment**
   ```bash
   docker compose up -d
   ```

8. **Verify everything works**
   ```bash
   docker compose ps
   docker compose logs
   ```

9. **Make your changes**
   - Edit files as needed
   - Test your changes thoroughly

10. **Keep your fork synchronized**
    ```bash
    git fetch upstream
    git rebase upstream/main
    ```

## 🔄 Pull Request Process

### Before Submitting

- [ ] Test your changes locally
- [ ] Ensure all containers start successfully
- [ ] Update documentation if needed
- [ ] Follow the [Style Guidelines](#style-guidelines)
- [ ] Check for typos and formatting issues
- [ ] Verify your changes don't break existing functionality

### Submitting a Pull Request

1. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add amazing new feature"
   ```

2. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

3. **Create a Pull Request**
   - Go to your fork on GitHub
   - Click "New Pull Request"
   - Fill in the PR template

### Pull Request Template

```markdown
## Description
Briefly describe what this PR does.

## Type of Change
- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update
- [ ] Configuration change

## Testing
Describe the tests you ran and how to reproduce them:
- [ ] Started fresh with `docker compose up -d`
- [ ] Tested feature X by doing Y
- [ ] Verified logs show no errors
- [ ] Tested on OS: [e.g., Ubuntu 22.04]

## Checklist
- [ ] My code follows the style guidelines of this project
- [ ] I have performed a self-review of my code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have tested my changes locally
- [ ] Any dependent changes have been merged and published

## Screenshots (if applicable)
Add screenshots to help reviewers understand your changes.

## Additional Notes
Any additional information that reviewers should know.
```

### After Submitting

- Be responsive to feedback
- Make requested changes promptly
- Keep your branch up to date
- Be patient - reviews may take time

## 📝 Style Guidelines

### Docker Compose

- Use 2 spaces for indentation
- Keep service definitions organized (proxy → web → app → database)
- Add comments for complex configurations
- Use descriptive service names
- Always specify container names
- Include health checks where applicable

### YAML Configuration

- Use 2 spaces for indentation
- Keep related settings grouped
- Add comments explaining non-obvious settings
- Use consistent naming conventions

### Shell Scripts

- Use `#!/bin/bash` shebang
- Add comments explaining complex logic
- Use meaningful variable names
- Check exit codes
- Add error handling

### Documentation

- Use clear, concise language
- Break up long sections with headers
- Include code examples where helpful
- Use proper Markdown formatting
- Test all commands and examples

### Commit Messages

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation changes
- `style`: Formatting changes (whitespace, missing semicolons, etc.)
- `refactor`: Code refactoring (neither fixes a bug nor adds a feature)
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Maintenance tasks (updating dependencies, etc.)

**Examples:**
```bash
git commit -m "feat(litellm): add support for new model provider"
git commit -m "fix(nginx): resolve SSL certificate loading issue"
git commit -m "docs(readme): add troubleshooting section"
git commit -m "chore(deps): update litellm to latest version"
```

### Branch Naming

- `feature/description` - For new features
- `fix/description` - For bug fixes
- `docs/description` - For documentation changes
- `refactor/description` - For code refactoring
- `chore/description` - For maintenance tasks

**Examples:**
- `feature/add-redis-caching`
- `fix/docker-compose-ports`
- `docs/improve-ssl-guide`

## 🏗️ Project Structure

```
litellm-stack/
├── .github/              # GitHub-specific files (future)
├── config/               # Configuration files
│   ├── litellm/         # LiteLLM configuration
│   └── nginx/           # Nginx configuration
├── scripts/              # Utility scripts
├── docs/                 # Additional documentation
├── docker-compose.yml    # Main orchestration file
├── .gitignore           # Git ignore rules
├── LICENSE              # MIT License
├── README.md            # Main documentation
└── CONTRIBUTING.md      # This file
```

## 🧪 Testing

### Manual Testing Checklist

Before submitting a PR, test:

- [ ] Fresh installation works: `docker compose up -d`
- [ ] All containers start successfully
- [ ] Health checks pass
- [ ] Open WebUI is accessible via HTTPS
- [ ] LiteLLM API responds
- [ ] Database connections work
- [ ] Logs show no errors
- [ ] SSL certificates load correctly
- [ ] Configuration changes take effect
- [ ] Services restart properly
- [ ] Data persists after restart

### Testing Commands

```bash
# Check all services are running
docker compose ps

# View logs
docker compose logs -f

# Test Open WebUI
curl -k https://localhost:8443

# Test LiteLLM API
curl http://localhost:4000/health

# Check PostgreSQL
docker compose exec postgres psql -U litellm -d litellm -c "\dt"

# Restart services
docker compose restart

# Clean restart
docker compose down -v && docker compose up -d
```

## 💬 Community

### Getting Help

- **Documentation**: Check the [docs](docs/) folder first
- **Issues**: Search [existing issues](https://github.com/yourusername/litellm-stack/issues)
- **Discussions**: Ask in [GitHub Discussions](https://github.com/yourusername/litellm-stack/discussions)

### Staying Updated

- Watch the repository for updates
- Star the project to show support
- Follow discussions and issues

### Communication Channels

- **GitHub Issues** - For bug reports and feature requests
- **GitHub Discussions** - For questions and general discussion
- **Pull Requests** - For code contributions

## 🎯 Areas We Need Help With

We're always looking for help in these areas:

- 📝 **Documentation** - Improving guides, adding examples
- 🐛 **Bug Reports** - Finding and reporting issues
- 💡 **Feature Ideas** - Suggesting improvements
- 🔧 **Code Contributions** - Implementing features and fixes
- 🌍 **Translations** - Translating documentation (future)
- 🧪 **Testing** - Testing on different platforms
- 📊 **Use Cases** - Sharing how you use the project

## 🙏 Recognition

Contributors will be:
- Listed in the README (once implemented)
- Mentioned in release notes
- Part of the project's history

## 📄 License

By contributing to LiteLLM-Stack, you agree that your contributions will be licensed under the MIT License.

---

## Questions?

Don't hesitate to ask! Open an issue with the `question` label, and we'll be happy to help.

Thank you for contributing to LiteLLM-Stack! 🚀

---

<div align="center">

**[⬆ Back to Top](#contributing-to-litellm-stack)**

</div>
