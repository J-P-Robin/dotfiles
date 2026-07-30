eval "$(/opt/homebrew/bin/brew shellenv)"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"

# ----- FNM -----
eval "$(fnm env --use-on-cd)"
