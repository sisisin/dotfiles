# ----------------------
# Aliases
# ----------------------
alias df='df -h'
alias ls='ls -CF'
alias ll='ls -al'
alias reload="exec $SHELL -l"
alias coded="code \"$(echo $DOTFILES_PATH)\""
alias da='direnv allow'
alias y='yarn'
alias p='pnpm'
alias tf='terraform'
alias lg='lazygit'
alias sc='sandbox-exec -f "$OneDrive/dotfiles/scripts/permissive-open.sb" -D TARGET_DIR="$(pwd)" -D HOME_DIR="$HOME" claude'
alias se='sandbox-exec -f "$OneDrive/dotfiles/scripts/permissive-open.sb" -D TARGET_DIR="$(pwd)" -D HOME_DIR="$HOME"'
alias tig='lazygit log'
alias mr='mise run'

# ----------------------
# Git Aliases
# ----------------------
alias g='git'
alias gb='git branch'
alias gbd='git branch --sort=-committerdate --format="%(committerdate:relative)%09%(refname:short)%09%09%09%(color:green)%(contents:subject)%(color:yellow)(%(authorname))"'
function gbdm() {
    git branch --merged | grep -vE '^\*|master$|develop|main$' | xargs -I % git branch -d %
}
function gbds() {
  local default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's/refs\/remotes\/origin\/\([^\/]*\).*/\1/')
  git branch --sort=-committerdate --format="%(committerdate:relative)%09%(refname:short)%09%(contents:subject)" | \
    grep -v "^[[:space:]]*[[:alnum:][:space:]]*${default_branch}[[:space:]]" | \
    peco | \
    awk -F'\t' '{print $2}' | \
    xargs -I % git branch -D %
}
alias gc='git commit '
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gcm='git commit -m'
alias gcmn='git commit -m'
alias gco='git checkout'
alias gcob='git checkout -b'
function gcom() {
    local default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's/refs\/remotes\/origin\/\([^\/]*\).*/\1/')
    git checkout $default_branch
}
function grbom() {
    local default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's/refs\/remotes\/origin\/\([^\/]*\).*/\1/')
    git rebase origin/$default_branch
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
# alias hpr='gh pr create -a "@me" -w'
function hpr(){
  title=$(git log --pretty=format:"%h %s" $(git merge-base origin/$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@') HEAD)..HEAD | peco --select-1 | cut -d' ' -f2-)

  gh pr create -a "@me" -t "$title" -w
}

alias hbr='gh repo view -w -b `git branch --show-current`'
alias hrw='gh repo view --web'

# ----------------------
# etc
# ----------------------
function really_clear() {
    clear && printf '\e[3J'
}

function set_title() {
    local b=${1-$(basename $(pwd))}
    printf "\033]2;%s\033\\r:r" "$b"
}

function set_tab_title() {
  echo -ne "\e]1;$1\a"
}
