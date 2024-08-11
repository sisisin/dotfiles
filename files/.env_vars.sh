# NOTE: for perf. cmd => brew --prefix
brew_prefix=$HOMEBREW_PREFIX

export GOPATH="$HOME/go"
export DOTFILES_PATH="${HOME}/OneDrive - simenyan/dotfiles"

export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:../node_modules/.bin"
export PATH="$PATH:${HOME}/dev/aplscript/bin"
export PATH="${HOME}/.local/bin:$PATH"
export PATH="$PATH:${DOTFILES_PATH}/bin"
export PATH="$PATH:${GOPATH}/bin"
export PGDATA=/usr/local/var/postgres
export OneDrive="$HOME/OneDrive - simenyan"
export SCANSNAP_SAVER_PATH="$HOME/items/scansnap-saver"
export SCANSNAP_DEPLOY_PATH="$HOME/OneDrive - simenyan/Apps/scansnap-saver"
export JAVA_HOME=$(/usr/libexec/java_home -v 1.11)
# export MAVEN_HOME=/usr/local/Cellar/maven/3.5.4

# GO
export ASDF_GOLANG_MOD_VERSION_ENABLED=false

# Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

export CLOUDSDK_PYTHON="$brew_prefix/bin/python3.9"

# readline for pkg-config
# export PKG_CONFIG_PATH="$(brew --prefix readline)/lib/pkgconfig"
# for rbenv
# openssl_dir="/usr/local/opt/openssl@1.1" # NOTE: for perf. cmd => brew --prefix openssl@1.1
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$openssl_dir"
# export RUBY_CONFIGURE_OPTS="--with-zlib-dir=/opt/homebrew/opt/zlib --with-openssl-dir=/opt/homebrew/opt/openssl@1.1 --with-readline-dir=/opt/homebrew/opt/readline --with-libyaml-dir=/opt/homebrew/opt/libyaml"
# export RUBY_CFLAGS="-Wno-error=implicit-function-declaration"

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
alias rgni='rg --no-ignore'
alias da='direnv allow'
alias yw='yarn workspace'
alias y='yarn'
alias p='pnpm'

# ----------------------
# Git Aliases
# ----------------------
alias g='git'
alias gb='git branch'
# alias gb='git branch --sort=-committerdate --format="%(refname:short)%09%(committerdate:relative)%09%(color:green)%(contents:subject)%(color:yellow)(%(authorname))"'
alias gbd='git branch -d '
function gbdm() {
    git branch --merged | grep -vE '^\*|master$|develop|main$' | xargs -I % git branch -d %
}
alias gbds='git branch -D `git branch | peco`'
alias gc='git commit --no-verify '
alias gca='git commit --no-verify --amend'
alias gcan='git commit --no-verify --amend --no-edit'
alias gcm='git commit --no-verify -m'
alias gco='git checkout'
alias gcob='git checkout -b'
function gcom() {
    local default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's/refs\/remotes\/origin\/\([^\/]*\).*/\1/')
    git checkout $default_branch
}
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
alias gp='git pull --prune'
alias gpu='git push'
alias gpuf='git push --force-with-lease'
alias grb='git rebase'
alias grbi='git rebase -i'
alias gro="git reset HEAD^"
alias gss='git status -s'
alias gst='git stash'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstd='git stash drop'

alias gcb='git rev-parse --abbrev-ref HEAD'
alias gch='git rev-parse HEAD'

# ----------------------
# Git Function
# ----------------------
# Git log find by commit message
function glf() { git log --all --grep="$1"; }

# https://github.com/not-an-aardvark/git-delete-squashed
gbdms() {
    local targetBranch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's/refs\/remotes\/origin\/\([^\/]*\).*/\1/')
    git checkout -q $targetBranch &&
        git branch --merged | grep -v "\*" | xargs -n 1 git branch -d &&
        git for-each-ref refs/heads/ "--format=%(refname:short)" |
        while read branch; do
            mergeBase=$(git merge-base $targetBranch $branch) &&
                [[ $(git cherry $targetBranch $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] &&
                git branch -D $branch
        done
}

# ----------------------
# gh Aliases
# ----------------------
alias hpw='gh pr view `git branch --show-current` --web'
alias hst='gh pr status'
alias hpr='gh pr create -w'
alias hprk='gh pr create -a "@me" -r "knowledge-work/backend,knowledge-work/knowledge-dev-backend" -f'
alias hbr='gh repo view -w -b `git branch --show-current`'
alias hrw='gh repo view --web'

# ----------------------
# python3 Aliases
# ----------------------

# alias python="${brew_prefix}/bin/python3"
# alias pip="${brew_prefix}/bin/pip3"

# ----------------------
# kube
# ----------------------

# ----------------------
# etc
# ----------------------
function really_clear() {
    clear && printf '\e[3J'
}

function out_ng() {
    local target=$1
    local query=".tunnels[] | select(.name == \"${target}\") | .public_url"
    curl http://localhost:4040/api/tunnels -s | jq -r $query
}

function kp() {
    local name=$1
    echo $(ps aux | grep "$name" | grep -v grep)

    echo "killします"
    echo "ok? (y/N): "
    if read -q; then
        echo "続行します"
        ps aux | grep "$name" | grep -v grep | awk '{ print "kill", $2 }' | bash
    else
        echo "やめました"
    fi

}

function set_title() {
    local b=${1-$(basename $(pwd))}
    printf "\033]2;%s\033\\r:r" "$b"
}

# Copy from https://github.com/antoniomo/gcloud-ps1
# Inspired in https://github.com/jonmosco/kube-ps1

GCLOUD_BIN="${GCLOUD_BIN:-gcloud}"
GCLOUD_PS1_ENABLE="${GCLOUD_PS1_ENABLE:-true}"
GCLOUD_PS1_SYMBOL_ENABLE="${GCLOUD_PS1_SYMBOL_ENABLE:-true}"
GCLOUD_PS1_SYMBOL="${GCLOUD_PS1_SYMBOL:-☁ }"

if [ "${ZSH_VERSION-}" ]; then
    GCLOUD_PS1_SHELL="zsh"
elif [ "${BASH_VERSION-}" ]; then
    GCLOUD_PS1_SHELL="bash"
fi

gcloudon() {
    GCLOUD_PS1_ENABLE=true
}

gcloudoff() {
    GCLOUD_PS1_ENABLE=false
}

gcloud_ps1() {
    # Terminal colors
    local reset='\033[0m'
    local blue='\033[1m\033[34m'
    local green='\033[1m\033[32m'

    GCLOUD_PS1=""
    if [[ ${GCLOUD_PS1_ENABLE} == true ]]; then
        GCLOUD_PS1+='('
        if [[ ${GCLOUD_PS1_SYMBOL_ENABLE} == true ]]; then
            GCLOUD_PS1+="${blue}${GCLOUD_PS1_SYMBOL} "
        fi
        ACTIVE_CONF=$(${GCLOUD_BIN} config configurations list --format='value(name)' --filter='IS_ACTIVE=true' 2>/dev/null)
        GCLOUD_PS1+="${green}$ACTIVE_CONF${reset})"
    fi

    echo "${GCLOUD_PS1}"
}

# let's encrypt

function copy_pem() {
    local domain=$1
    local pem_path="/etc/letsencrypt/live/${domain}/fullchain.pem"
    local key_path="/etc/letsencrypt/live/${domain}/privkey.pem"
    local cert_path="/etc/letsencrypt/live/${domain}/cert.pem"

    local dest_path="${DOTFILES_PATH}/letsencrypt/${domain}"
    mkdir -p $dest_path

    sudo cp $pem_path $dest_path
    sudo cp $key_path $dest_path
    sudo cp $cert_path $dest_path
    sudo chown -R $USER $dest_path
    sudo chmod 600 $dest_path/*
}
