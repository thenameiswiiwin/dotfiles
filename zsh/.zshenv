# Basic PATH
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:/opt/homebrew/opt/mysql@5.7/bin:$PATH"
export PATH="$HOME/go/bin:$HOME/flutter/bin:$HOME/.bun/bin:$HOME/Library/pnpm:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"

# Editors
export EDITOR="/opt/homebrew/bin/nvim"
export VISUAL="$EDITOR"
export GIT_EDITOR="$EDITOR"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

# Starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# Atuin
eval "$(atuin init zsh)"
#
# Zoxide
eval "$(zoxide init zsh)"

# # fnm (Node version manager)
eval "$(fnm env --use-on-cd --shell zsh)"

