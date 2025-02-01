#!/usr/bin/env bash
#
# install.sh
# A script to set up your dotfiles on macOS.

set -euo pipefail

# Request sudo
echo "Requesting sudo privileges..."
sudo -v
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# Xcode Command Line Tools (macOS)
if ! xcode-select --print-path &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
else
  echo "Xcode Command Line Tools already installed."
fi

# Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed. Updating..."
  brew update && brew upgrade
fi

# Dotfiles Repo
DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_REPO="https://github.com/thenameiswiiwin/dotfiles-2025.git"

if [ -d "$DOTFILES_DIR" ]; then
  echo "Dotfiles directory already exists at $DOTFILES_DIR."
  echo "Skipping clone step."
else
  echo "Cloning dotfiles repository from $DOTFILES_REPO..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

# Brewfile
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
  echo "Running Brewfile..."
  cd "$DOTFILES_DIR" || exit
  brew bundle
  cd - >/dev/null
else
  echo "[WARN] Brewfile not found in $DOTFILES_DIR."
fi

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Python
if ! command -v python3 &>/dev/null; then
  echo "[INFO] Installing Python via Homebrew..."
  brew install python
else
  echo "[INFO] Python already installed. Upgrading pip..."
  brew upgrade python
fi

# Rust
if ! command -v rustc &>/dev/null; then
  echo "Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

# Install bob-nvim for managing Neovim versions
if ! command -v bob &>/dev/null; then
  cargo install bob-nvim
  bob install stable
  bob use stable
fi

# Bun
# For official installation steps: https://bun.sh/
if ! command -v bun &>/dev/null; then
  echo "[INFO] Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
  # The script adds Bun to ~/.bun & modifies your shell config
  # Ensure you restart or source that file if needed
else
  echo "[INFO] Bun is already installed."
fi

# Tmux Plugin Manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing Tmux Plugin Manager..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Git Config
git config --global user.name "Huy Nguyen"
git config --global user.email "huyn.nguyen95@gmail.com"
git config --global credential.helper store

# GH Copilot CLI
if command -v gh &>/dev/null; then
  gh auth login
  gh extension install github/gh-copilot
  gh extension upgrade gh-copilot
fi

# Docker
if ! command -v docker &>/dev/null; then
  echo "[INFO] Installing Docker Desktop..."
  brew install --cask docker
  brew install docker
  echo "[NOTE] Docker Desktop installed. You may need to launch Docker.app from your Applications folder"
  echo "and follow any prompts to finalize the Docker installation."
else
  echo "[INFO] Docker is already installed."
fi

# Node via fnm (Fast Node Manager)
echo "Setting up fnm..."
eval "$(fnm env)"
fnm install --lts
fnm ls

# Clean Up
brew cleanup

echo "================================================="
echo "✔ Dotfiles install complete!"
echo "Open a new terminal or 'source ~/.zshrc' to load."
echo "================================================="
