[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# ----- Bun -----
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ----- FNM -----
# Script-installed fnm (Linux) lands here; no-op on macOS where Homebrew provides fnm
[ -d "$HOME/.local/share/fnm" ] && export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd)"

# ----- OpenCode -----
export PATH="$HOME/.opencode/bin:$PATH"
