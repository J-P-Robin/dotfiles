# ----- Secrets (gitignored, not in this repo) -----
[ -f "$HOME/.zshrc.secrets" ] && source "$HOME/.zshrc.secrets"

# ----- Oh My Zsh -----
export ZSH=$HOME/.oh-my-zsh

export THEME_MODE="dark"

zstyle ':omz:update' mode auto

plugins=(
  git
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ----- Homebrew -----
export PATH=/opt/homebrew/bin:$PATH

export PATH="$HOME/.local/bin:$PATH"

# ----- Neovim -----
export PATH="$PATH:/opt/nvim/"
# export TERM=xterm-256color

# ----- FZF -----
# TODO: fix issue with Sublime Merge
# source <(fzf --zsh)
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
# alias sd="cd ~ && cd \$(find * -type d | fzf)"
# export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
# export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
# _fzf_comprun() {
#   local command=$1
#   shift

#   case "$command" in
#     cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
#     export|unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
#     ssh)          fzf --preview 'dig {}' "$@" ;;
#     *)            fzf --preview "--preview 'bat -n --color=always --line-range :500 {}'" "$@" ;;
#   esac
# }

# ----- FNM -----
eval "$(fnm env --use-on-cd --version-file-strategy=local)"
# export FNM_DIR="$HOME/.fnm"
# [ -s "$FNM_DIR/fnm.sh" ] && \. "$FNM_DIR/fnm.sh"
# export PATH="$FNM_DIR:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# ----- BAT -----
export BAT_THEME="Catppuccin Mocha"

# ----- WGET -----
alias wget="wget2"

# ----- Oh My Posh -----
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.json)"
fi

# ----- OPENCODE -----
export EDITOR="surf"

# ----- TMUX -----
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=241'
export DISABLE_AUTO_TITLE="true"

# ----- EZA -----
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# ----- Windsurf -----
export PATH="/Applications/Windsurf.app/Contents/Resources/app/bin:$PATH"

# ----- ZOXIDE -----
eval "${$(zoxide init zsh):s#_files -/#_cd#}"


# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/83/"

# Herd injected PHP binary.
export PATH="$HOME/Library/Application Support/Herd/bin/":$PATH


# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/84/"


# Herd injected PHP 8.2 configuration.
export HERD_PHP_82_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/82/"

# opencode
export PATH=$HOME/.opencode/bin:$PATH

# Added by Windsurf
export PATH="$HOME/.codeium/windsurf/bin:$PATH"

# Herd injected PHP 8.1 configuration.
export HERD_PHP_81_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/81/"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
