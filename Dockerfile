FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/root

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    build-essential \
    tar \
    sudo \
    ca-certificates \
    gnupg \
    software-properties-common \
    ripgrep \
    fd-find \
    fzf \
    postgresql-client \
    tmux \
    xclip \
    clang \
    fontconfig \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/share/fonts && \
    curl -fLo /tmp/JetBrainsMono.tar.xz "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.tar.xz" && \
    tar -xf /tmp/JetBrainsMono.tar.xz -C /usr/share/fonts && \
    fc-cache -f /usr/share/fonts && \
    rm /tmp/JetBrainsMono.tar.xz

WORKDIR /tmp
RUN curl -fLO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && \
    tar xzf nvim-linux64.tar.gz && \
    mv nvim-linux64 /opt/nvim && \
    ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim && \
    rm nvim-linux64.tar.gz

RUN curl -fLO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

RUN curl -fLo /tmp/terraform.zip https://releases.hashicorp.com/terraform/1.11.2/terraform_1.11.2_linux_amd64.zip && \
    unzip /tmp/terraform.zip -d /usr/local/bin && \
    rm /tmp/terraform.zip

RUN curl -fLo /tmp/k9s.tar.gz https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz && \
    tar xzf /tmp/k9s.tar.gz -C /usr/local/bin k9s && \
    rm /tmp/k9s.tar.gz

RUN curl -fLo /tmp/e1s.tar.gz https://github.com/keidarcy/e1s/releases/latest/download/e1s_Linux_x86_64.tar.gz && \
    tar xzf /tmp/e1s.tar.gz -C /usr/local/bin e1s && \
    rm /tmp/e1s.tar.gz

RUN curl -fsSL https://opencode.ai/install | bash

RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
    curl -fLo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
    tar xzf /tmp/lazygit.tar.gz -C /tmp && \
    mv /tmp/lazygit /usr/local/bin/ && \
    rm /tmp/lazygit.tar.gz

RUN curl -fLo /tmp/tree-sitter-linux-x64.gz https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-x64.gz && \
    gunzip /tmp/tree-sitter-linux-x64.gz && \
    chmod +x /tmp/tree-sitter-linux-x64 && \
    mv /tmp/tree-sitter-linux-x64 /usr/local/bin/tree-sitter

WORKDIR $HOME

RUN git clone --depth 1 https://github.com/LazyVim/starter ~/.config/nvim && \
    rm -rf ~/.config/nvim/.git

COPY config/nvim/lua/config/options.lua ~/.config/nvim/lua/config/options.lua
COPY config/nvim/lua/config/keymaps.lua ~/.config/nvim/lua/config/keymaps.lua
COPY config/nvim/lua/config/autocmds.lua ~/.config/nvim/lua/config/autocmds.lua
COPY config/nvim/lua/plugins/ ~/.config/nvim/lua/plugins/
COPY config/nvim/stylua.toml ~/.config/nvim/stylua.toml

RUN mkdir -p ~/.config/tmux/plugins && \
    git clone --depth 1 https://github.com/catppuccin/tmux ~/.config/tmux/plugins/catppuccin/tmux

COPY config/tmux/.tmux.conf ~/.tmux.conf

WORKDIR /workspace

ENTRYPOINT ["/bin/bash"]