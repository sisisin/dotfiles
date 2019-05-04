if [ -f $(brew --prefix)/etc/brew-wrap ]; then
    source $(brew --prefix)/etc/brew-wrap
fi

hlcp() {
    pbpaste | highlight $* -O rtf -K 24 | pbcopy
}
hlcpf() {
    pbpaste | highlight $* -O rtf -K 24 -s Breeze | pbcopy
}

alias jxa='osascript -l JavaScript'
alias rm='rm -i'
alias df='df -h'
alias ls='ls -CF'
alias wdiff="git diff --no-index --word-diff-regex='\\w+|[^[:space:]]'"
alias srv="python -m SimpleHTTPServer"

# ----------------------
# Git Aliases
# ----------------------
alias ga='git add'
alias gaa='git add .'
alias gaaa='git add -A'
alias gb='git branch'
alias gbd='git branch -d '
alias gbds='git branch -D `git branch | peco`'

function gbdm() {
    git branch --merged | grep -vE '^\*|master$|develop$' | xargs -I % git branch -d %
}

alias gc='git commit'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
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
