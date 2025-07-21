# MetaMask Extension E2E Docker Image

This image is built for running MetaMask Extension end-to-end (E2E) tests.  
It includes:

- Node 22.15 (with browsers)
- Yarn 4.9.1 (via Corepack)
- zstd compression tool
- Xvfb for headless GUI environments

## 🚀 Using the Image

### Pull from GHCR

```bash
# Latest version
docker pull ghcr.io/consensys-vertical-apps/metamask-extension-e2e-image:latest

# Specific version
docker pull ghcr.io/consensys-vertical-apps/metamask-extension-e2e-image:v1.0.0
```

### Authentication

For public access, you can use any GitHub token:

```bash
# Login to GHCR
echo $GITHUB_TOKEN | docker login ghcr.io -u $GITHUB_USERNAME --password-stdin

# Or using GitHub CLI
gh auth token | docker login ghcr.io -u $GITHUB_USERNAME --password-stdin
```

### Using in CI/CD

#### GitHub Actions

```yaml
steps:
  - name: Login to GHCR
    uses: docker/login-action@v3
    with:
      registry: ghcr.io
      username: ${{ github.actor }}
      password: ${{ secrets.GITHUB_TOKEN }}
  
  - name: Run E2E tests
    run: |
      docker run --rm -v $PWD:/workspace \
        ghcr.io/consensys-vertical-apps/metamask-extension-e2e-image:latest \
        yarn test:e2e
```

#### Docker Compose

```yaml
version: '3.8'
services:
  e2e-tests:
    image: ghcr.io/consensys-vertical-apps/metamask-extension-e2e-image:latest
    volumes:
      - ./:/workspace
    working_dir: /workspace
    command: yarn test:e2e
```

## 🔨 Building the Image Locally

```bash
# Build for local development
docker build -t metamask-extension-e2e-local .

# Build with platform specification
docker build --platform linux/amd64 -t metamask-extension-e2e-local .
```

## 📦 Available Tags

- `latest` - Latest build from main branch
- `v*.*.*` - Tagged releases
- `main` - Main branch builds
- `<sha>` - Specific commit builds

## 📋 Requirements

- Docker
- GitHub account (for pulling from GHCR)
- GitHub token with `read:packages` permission

## 🐛 Troubleshooting

### Authentication Issues

```bash
# Check if you're logged in
docker system info | grep -i registry

# Test image access
docker run --rm ghcr.io/consensys-vertical-apps/metamask-extension-e2e-image:latest echo "Success"
```

### Common Solutions

1. **Permission Denied**: Ensure your GitHub token has `read:packages` permission
2. **Image Not Found**: Check image name spelling and tag existence
3. **Rate Limiting**: Use authenticated requests to avoid rate limits

## 🏗️ Development

This image is automatically built and pushed to GHCR on:
- All branch commits (for testing and development)
- Tagged releases
- Pull requests

## 📞 Support

- **Issues**: Open an issue in this repository
- **Internal**: Contact via Slack #mmig-devsecops-random
