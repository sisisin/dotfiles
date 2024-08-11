# zmodload zsh/zprof

zmodload zsh/datetime
start_time=$(strftime '%s%.')


[[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

source ~/.env_vars.sh

source "$OneDrive/dotfiles/scripts/zshlib.sh"

# background image changer
source "$OneDrive/dotfiles/scripts/bg/bg.sh"
configure_image_lists
zle -N set_background_random
bindkey '^m' set_background_random

bindkey "[C" forward-word
bindkey "[D" backward-word

# setup ghq
zle -N peco_src
bindkey '^g' peco_src

if type brew &>/dev/null; then
    FPATH=$brew_prefix/share/zsh/site-functions:$FPATH
fi
FPATH=$brew_prefix/share/zsh-completions:$FPATH

# runtime version manager
# Check if $HOME/.asdf/asdf.sh exists and source it
if [ -f "$HOME/.asdf/asdf.sh" ]; then
    . "$HOME/.asdf/asdf.sh"
elif [ -f "$(brew --prefix asdf)/libexec/asdf.sh"]; then
    . "$(brew --prefix asdf)/libexec/asdf.sh"
fi

# for golang
. ~/.asdf/plugins/golang/set-env.zsh

fpath=(${ASDF_DIR}/completions $fpath)

# for Ruby
export ASDF_RUBY_BUILD_VERSION=master

# ----------------------
# zsh configuration
# ----------------------

# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit -u
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
# HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
bindkey -e
# End of lines configured by zsh-newuser-install

# vcs setting
autoload -Uz colors
colors

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

precmd() {
    RETVAL=$?
    vcs_info
}

PROMPT='%{$([ $RETVAL -eq 0 ] && echo "\e[32m✔" || echo "\e[31m✖")%}%{$reset_color%} [%~] ${vcs_info_msg_0_}
%# '

# 少し凝った zshrc
# License : MIT
# http://mollifier.mit-license.org/

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完で小文字でも大文字にマッチさせる

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
    /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

zstyle ':completion:*:processes' command 'ps x -o pid,s,args' # ps コマンドのプロセス名補完

########################################
# オプション

setopt print_eight_bit      # 日本語ファイル名を表示可能にする
setopt no_flow_control      # フローコントロールを無効にする
setopt interactive_comments # '#' 以降をコメントとして扱う
setopt hist_ignore_all_dups # 同じコマンドをヒストリに残さない
setopt hist_ignore_space    # スペースから始まるコマンド行はヒストリに残さない
setopt hist_reduce_blanks   # ヒストリに保存するときに余分なスペースを削除する
setopt inc_append_history
setopt share_history

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

########################################

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

########################################
# peco

# C-rでコマンド履歴がpeco経由で見れる
zle -N peco-select-history
bindkey '^R' peco-select-history

# ----------------------
# common configuration
# ----------------------
# homebrew-file
if [ -f $brew_prefix/etc/brew-wrap ]; then
    source $brew_prefix/etc/brew-wrap
fi

# https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-completion.html
# export PATH="$PATH:/usr/local/bin/aws_completer"
autoload bashcompinit && bashcompinit
# complete -C '/usr/local/bin/aws_completer' aws

eval $(gh completion -s zsh)

# kubectl completion
function _kubectl() {
    unfunction $0
    source <(kubectl completion zsh)
    source <(kubectl argo rollouts completion zsh)
    $0
}

compdef _kubectl kubectl
alias k=kubectl
complete -F __start_kubectl k

eval "$(op completion zsh)"; compdef _op op

# if [ -f "$HOME/.minikube-completion" ]; then . "$HOME/.minikube-completion"; fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/dev/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/dev/google-cloud-sdk/path.zsh.inc"; fi

[[ -f "$HOME/dev/google-cloud-sdk/completion.zsh.inc" ]] && . "$HOME/dev/google-cloud-sdk/completion.zsh.inc"

# ---------

end_time=$(strftime '%s%.')
echo $((end_time - start_time))

if type zprof >/dev/null 2>&1; then
    zprof | less
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

eval "$(direnv hook zsh)"
