export DOTFILES_PATH="${HOME}/OneDrive - simenyan/dotfiles"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:../node_modules/.bin"
export PATH="$PATH:${HOME}/dev/aplscript/bin"
export PATH="$PATH:${DOTFILES_PATH}/bin"
export PLAY_MAILER_PORT=25000
export PGDATA=/usr/local/var/postgres
export ASPNETCORE_ENVIRONMENT=Development
export OneDrive="$HOME/OneDrive - simenyan"
export SCANSNAP_SAVER_PATH="$HOME/items/scansnap-saver"
export SCANSNAP_DEPLOY_PATH="$HOME/OneDrive - simenyan/Apps/scansnap-saver"
export GOPATH="$HOME/go"
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export MAVEN_HOME=/usr/local/Cellar/maven/3.5.4

# readline for pkg-config
export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"
# for rbenv
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

export EDITOR='code --wait'
[[ -f ~/.env_vars_optional.sh ]] && source ~/.env_vars_optional.sh

# ----------------------
# Aliases
# ----------------------
alias rm='rm -i'
alias df='df -h'
alias ls='ls -CF'
alias ll='ls -al'
alias reload="exec $SHELL -l"
alias cdd="cd \"$(echo $DOTFILES_PATH)\""
alias coded="code \"$(echo $DOTFILES_PATH)\""
alias be="bundle exec"
alias b="bundle"

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
alias glg='git log --graph --oneline --decorate'
alias glga='git log --graph --oneline --decorate --all'
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

# ----------------------
# gh Aliases
# ----------------------
alias hpw='gh pr view --web'
alias hrw='gh repo view --web'

# ----------------------
# python3 Aliases
# ----------------------

alias python=/usr/local/bin/python3
alias pip=/usr/local/bin/pip3
