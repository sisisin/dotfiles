export CLICOLOR=1
LS_OPTIONS='--color=auto'
export LSCOLORS=gxfxcxdxbxegedabagacad
export PATH=$PATH:./node_modules/.bin
export PATH=$PATH:../node_modules/.bin
export PATH=$PATH:${HOME}/dev/aplscript/bin
export PLAY_MAILER_PORT=25000
export PGDATA=/usr/local/var/postgres
export ASPNETCORE_ENVIRONMENT=Development

# source ~/.env_vars.sh

# export ASDF_DATA_DIR="$(brew --prefix asdf)/"
# fixme: xcodeでbrew not foundになる
export ASDF_DATA_DIR="/opt/homebrew/opt/asdf"
[[ -f "$ASDF_DATA_DIR/asdf.sh" ]] && . "$ASDF_DATA_DIR/asdf.sh"

test -r ~/.bashrc && . ~/.bashrc

# git completions
[ -f /usr/local/etc/bash_completion.d/git-completion.bash ] && . /usr/local/etc/bash_completion.d/git-completion.bash
[ -f /usr/local/etc/bash_completion.d/git-prompt.sh ] && . /usr/local/etc/bash_completion.d/git-prompt.sh

PS1='[\w\[\e[0;32m\]$(__git_ps1)\[\e[00m\]]\$ '

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
