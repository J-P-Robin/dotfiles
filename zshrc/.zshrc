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

# ----- Zed -----
export PATH=$HOME/.local/bin:$PATH

# ----- Homebrew -----
export PATH=/opt/homebrew/bin:$PATH

# ----- Neovim -----
export PATH="$PATH:/opt/nvim/"
# export TERM=xterm-256color

# ----- FZF -----
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
alias sd="cd ~ && cd \$(find * -type d | fzf)"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview "--preview 'bat -n --color=always --line-range :500 {}'" "$@" ;;
  esac
}

# ----- FNM -----
eval "$(fnm env --use-on-cd)"

# ----- BAT -----
export BAT_THEME="Catppuccin Mocha"

# ----- WGET -----
alias wget="wget2"

# ----- Oh My Posh -----
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.json)"
fi

# ----- TMUX -----
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=241'
DISABLE_AUTO_TITLE="true"

# ----- EZA -----
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# ----- ZOXIDE -----
eval "${$(zoxide init zsh):s#_files -/#_cd#}"
alias cd=z
