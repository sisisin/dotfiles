export DOTFILES_PATH="${HOME}/OneDrive - simenyan/dotfiles"
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:./node_modules/.bin
export PATH=$PATH:../node_modules/.bin
export PATH=$PATH:${HOME}/dev/aplscript/bin
export PATH=$PATH:${DOTFILES_PATH}/bin
export PLAY_MAILER_PORT=25000
export PGDATA=/usr/local/var/postgres
export ASPNETCORE_ENVIRONMENT=Development
export OneDrive="$HOME/OneDrive - simenyan"
export SCANSNAP_SAVER_PATH="$HOME/items/scansnap-saver"
export SCANSNAP_DEPLOY_PATH="$HOME/OneDrive - simenyan/Apps/scansnap-saver"
export GOPATH="$HOME/go"
export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

[[ -f ~/_env_vars_optional.sh ]] && source ~/_env_vars_optional.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

eval "$(rbenv init -)"

eval "$(direnv hook zsh)"
show_virtual_env() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo "($(basename $VIRTUAL_ENV))"
    fi
}
PS1='$(show_virtual_env)'$PS1

export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export MAVEN_HOME=/usr/local/Cellar/maven/3.5.4

alias jxa='osascript -l JavaScript'
alias rm='rm -i'
alias df='df -h'
alias ls='ls -CF'
alias ll='ls -l'
alias wdiff="git diff --no-index --word-diff-regex='\\w+|[^[:space:]]'"
alias srv="python -m SimpleHTTPServer"
alias reload="exec $SHELL -l"
alias cdd="cd \"$(echo $DOTFILES_PATH)\""
alias coded="code \"$(echo $DOTFILES_PATH)\""
alias be="bundle exec"

function code() {
    (vsc-ext-manager check-diff &)
    /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code $@
}

# ----------------------
# Git Aliases
# ----------------------
alias g='git'
alias gb='git branch'
alias gbd='git branch -d '
function gbdm() {
    git branch --merged | grep -vE '^\*|master$|develop$' | xargs -I % git branch -d %
}
alias gbds='git branch -D `git branch | peco`'
alias gc='git commit'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gcod='git checkout develop'
alias gcosb='git checkout `git branch | peco`'
alias gd='git diff'
alias gda='git diff HEAD'
alias gdn='git diff --name-only origin/master'
alias gi='git init'
alias gl='git log'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gp='git pull'
alias gpu='git push'
alias gpuf='git push --force-with-lease'
alias grb='git rebase'
alias grbi='git rebase -i'
alias grbom='git rebase origin/master'
alias gro="git reset HEAD^"
alias gss='git status -s'
alias gst='git stash'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstd='git stash drop'

# ----------------------
# Git Function
# ----------------------
# Git log find by commit message
function glf() { git log --all --grep="$1"; }

# ----------------------
# hub Aliases
# ----------------------
alias hpr='hub pull-request'
alias hbr='hub browse'

# background image changer

source "$OneDrive/dotfiles/scripts/bg/bg.sh"

configure_image_lists
zle -N set_background
bindkey '^m' set_background
