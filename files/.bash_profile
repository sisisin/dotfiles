export CLICOLOR=1
LS_OPTIONS='--color=auto'
export LSCOLORS=gxfxcxdxbxegedabagacad

export OneDrive="$HOME/OneDrive - simenyan"
export DOTFILES_PATH="${OneDrive}/dotfiles"
export EDITOR='code --wait'
export PATH="$PATH:$HOME/.local/share/mise/shims"
export PATH="$PATH:${HOME}/.local/bin"
export PATH="$PATH:${DOTFILES_PATH}/bin"

[[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(~/.local/bin/mise activate bash)"

source "$OneDrive/dotfiles/scripts/shelllib.sh"

PS1='[\w\[\e[0;32m\]\[\e[00m\]]\$ '
