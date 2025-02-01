# Source ~/.zshenv
[ -f "$HOME/.zshenv" ] && source "$HOME/.zshenv"

# Oh My Zsh
ZSH_THEME=""  # or "robbyrussell"
source "$ZSH/oh-my-zsh.sh"

# Plugins & Completions
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

# Bun completions
if [ -f "$HOME/.bun/_bun" ]; then
  source "$HOME/.bun/_bun"
fi

# Rust (Cargo) environment
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

# zsh-syntax-highlighting & zsh-autosuggestions
if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Killport
findandkill() {
  local pids
  pids="$(lsof -ti:3000)"
  if [ -n "$pids" ]; then
    kill "$pids"
  fi
}

# Tmux sessionizer
bindkey -s "^f" "tmux-sessionizer\n"

# macOS Keyboard Tweaks
if [[ "$OSTYPE" == "darwin"* ]]; then
  defaults write NSGlobalDomain KeyRepeat -int 1
  defaults write NSGlobalDomain InitialKeyRepeat -int 15
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
fi

# 7. Terraform Autocomplete
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# bun completions
[ -s "/Users/huy/.bun/_bun" ] && source "/Users/huy/.bun/_bun"

# pnpm
export PNPM_HOME="/Users/huy/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
