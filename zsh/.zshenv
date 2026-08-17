eval "$(/opt/homebrew/bin/brew shellenv)"

# ----- Bun -----
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ----- FNM -----
eval "$(fnm env --use-on-cd)"

# ----- OpenCode -----
export PATH="$HOME/.opencode/bin:$PATH"
