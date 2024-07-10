# ----- Oh My Zsh -----
export ZSH=$HOME/.oh-my-zsh

zstyle ':omz:update' mode auto

DISABLE_AUTO_TITLE="true"

plugins=(
  git
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ----- Homebrew -----
export PATH=/opt/homebrew/bin:$PATH

# ----- Neovim -----
export PATH="$PATH:/opt/nvim/"

# ----- FZF -----
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
alias sd="cd ~ && cd \$(find * -type d | fzf)"

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
