function get_time() {
    echo $(ruby -e "print Time.now.strftime('%s%L').to_i")
}
# usage
# s=$(get_time); e=$(get_time); show_time $s $e
function show_time() {
    local start=$1
    local end=$2
    echo $((end - start))
}

start_time=$(get_time)
source ~/.env_vars.sh

# background image changer
source "$OneDrive/dotfiles/scripts/bg/bg.sh"
configure_image_lists
zle -N set_background
bindkey '^m' set_background

# setup ghq
function peco_src() {
    local repo=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$repo" ]; then
        repo=$(ghq list --full-path --exact $repo)
        BUFFER="cd ${repo}"
        zle accept-line
    fi
}
zle -N peco_src
bindkey '^g' peco_src

if type brew &>/dev/null; then
    FPATH=$brew_prefix/share/zsh/site-functions:$FPATH
fi
FPATH=/usr/local/share/zsh-completions:$FPATH
FPATH="${HOME}/.completion/zsh-completions":$FPATH

# runtime version manager
. $HOME/.asdf/asdf.sh
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
HISTFILE=~/.histfile
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
    vcs_info
}

PROMPT='[%~] ${vcs_info_msg_0_}%# '

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
function peco-select-history() {
    # historyを番号なし、逆順、最初から表示。
    # 順番を保持して重複を削除。
    # カーソルの左側の文字列をクエリにしてpecoを起動
    # \nを改行に変換
    BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER # カーソルを文末に移動
    zle -R -c       # refresh
}
zle -N peco-select-history
bindkey '^R' peco-select-history

# ----------------------
# common configuration
# ----------------------
# homebrew-file
if [ -f $brew_prefix/etc/brew-wrap ]; then
    source $brew_prefix/etc/brew-wrap
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

eval "$(direnv hook zsh)"

# https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-completion.html
export PATH="/usr/local/bin/aws_completer:$PATH"
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

eval $(gh completion -s zsh)
export PATH="/usr/local/bin/rubocop-daemon-wrapper:$PATH"

end_time=$(get_time)
show_time $start_time $end_time
