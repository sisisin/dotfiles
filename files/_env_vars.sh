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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

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
alias cdd="cd $(echo $DOTFILES_PATH)"
alias coded="code $(echo $DOTFILES_PATH)"

function code() {
    (ruby $DOTFILES_PATH/scripts/check_diff_vscode_extension.rb &)
    /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code $@
}

# ----------------------
# Git Aliases
# ----------------------
alias gb='git branch'
alias gbd='git branch -d '
alias gbds='git branch -D `git branch | peco`'

function gbdm() {
    git branch --merged | grep -vE '^\*|master$|develop$' | xargs -I % git branch -d %
}

alias gc='git commit --no-verify'
alias gca='git commit --amend --no-verify'
alias gcan='git commit --amend --no-edit --no-verify'
alias gcm='git commit --no-verify -m'
alias gco='git checkout'
alias gcom='git checkout master'
alias gcod='git checkout develop'
alias gcosb='git checkout `git branch | peco`'
alias gd='git diff'
alias gda='git diff HEAD'
alias gdn='git diff --name-only master'
alias gi='git init'
alias gl='git log'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gp='git pull'
alias gss='git status -s'
alias gst='git stash'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstd='git stash drop'

function gcob() {
    if [[ $# -lt 1 ]]; then
        echo "引数は1つ以上指定して"
        return
    fi
    local branch_name=$1
    local start_point=${2:-origin/master}
    cmd="git checkout -b $branch_name $start_point"
    echo $cmd
    eval $cmd
}

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

function set_image_lists() {
    local image_index=1
    find "$HOME/OneDrive - simenyan/画像/background" -name "*.png" -o -name "*.jpg" -o -name "*.gif" | while read f; do
        image_list1[image_index]="$f"
        image_index=$(($image_index + 1))
    done
    image_index=1
    find "$HOME/OneDrive - simenyan/画像/kef/カントク" -name "*.png" -o -name "*.jpg" -o -name "*.gif" | while read f; do
        image_list2[image_index]="$f"
        image_index=$(($image_index + 1))
    done
}
set_image_lists

image_index=1
bg() {
    if [ -z "$BUFFER" ]; then
        image_index=$(($RANDOM % ${#image_list1[@]} + 1))
        image_path=$image_list1[$image_index]
        (osascript ~/set_background_image.applescript $image_path &)
        zle reset-prompt
    fi

    zle accept-line
}

d() {
    local image_index=$(($RANDOM % ${#image_list2[@]} + 1))
    image_path=$image_list2[$image_index]
    (osascript ~/set_background_image.applescript $image_path &)
}

zle -N bg
bindkey '^m' bg

[[ -f ~/_env_vars_optional.sh ]] && source ~/_env_vars_optional.sh
