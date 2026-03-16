# devenv

Dockerized Linux-based development environment with Neovim (LazyVim), tmux, and essential DevOps tools.

## Prerequisites

- Docker installed on your system
- A terminal that supports true color and undercurl (kitty, wezterm, alacritty, etc.)

## Build Locally

```bash
docker build -t devenv:latest .
```

## Quick Start

```bash
# Create and start container
docker run -dit --name devenv ghcr.io/mahshaban95/devenv:latest

# Enter container
docker exec -it devenv bash

# Stop container when done
docker stop devenv

# Resume later
docker start devenv
docker exec -it devenv bash

# Delete and start fresh
docker rm -f devenv
docker run -dit --name devenv ghcr.io/mahshaban95/devenv:latest
```

## Pull from GHCR

```bash
docker pull ghcr.io/mahshaban95/devenv:latest
```

## Persistence

The named container (`--name devenv`) keeps all data in its writable layer:
- Neovim plugins (installed on first run)
- Git repositories
- Config files
- Any other files you create

Data persists until you explicitly delete the container with `docker rm`.

## Included Tools

- **Neovim** (v0.11.6) with LazyVim starter + custom plugins
- **Tmux** with catppuccin theme
- **kubectl** - Kubernetes CLI
- **Terraform** - Infrastructure as Code
- **k9s** - Kubernetes TUI
- **e1s** - Elasticsearch TUI
- **OpenCode** - AI coding assistant
- **lazygit** - Git TUI
- **fzf**, **ripgrep**, **fd-find** - Fast find/search tools
- **PostgreSQL client**
- **tree-sitter-cli** + build tools

## Custom Neovim Plugins

- catppuccin colorscheme
- opencode.nvim
- nvim-dbee
- pyworks.nvim (with molten-nvim, jupytext, image.nvim)

## Configuration Files

- `config/nvim/` - Custom LazyVim overrides (merged with LazyVim starter)
- `config/tmux/.tmux.conf` - Tmux configuration with OSC52 clipboard support