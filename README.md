# devenv

Dockerized Linux-based development environment with Neovim (LazyVim), tmux, and essential DevOps tools.

## Prerequisites

- Docker installed on your system
- A terminal that supports true color and undercurl (kitty, wezterm, alacritty, etc.)

## Build Locally

```bash
docker build -t devenv:latest .
```

## Run Container

```bash
# Run interactively (ephemeral)
docker run -it --rm ghcr.io/mahshaban95/devenv:latest

# Run in background (persistent)
docker run -dit --name devenv ghcr.io/mahshaban95/devenv:latest

# Attach to running container
docker exec -it devenv bash

# Or attach directly
docker attach devenv
```

## Pull from GHCR

```bash
docker pull ghcr.io/mahshaban95/devenv:latest
```

## Persistence (Optional)

To persist data across sessions, consider using cloud storage solutions like Cloudflare R2 with rclone. Configuration for persistence will be handled separately.

## Included Tools

- **Neovim** (latest) with LazyVim starter + custom plugins
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