# zmodload zsh/zprof
zmodload zsh/datetime
start_time=$(strftime '%s%.')

# environment variables setup start ----------------------
export OneDrive="$HOME/OneDrive - simenyan"
export DOTFILES_PATH="${OneDrive}/dotfiles"
export PGDATA=/usr/local/var/postgres
export CLOUDSDK_PYTHON="/opt/homebrew/bin/python3" # gcloud
export EDITOR='code --wait'

export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:../node_modules/.bin"
export PATH="$PATH:${HOME}/.local/bin"
export PATH="$PATH:${DOTFILES_PATH}/bin"
export PATH="$PATH:${HOME}/.duckdb/cli/latest" # duckdb
[[ -f ~/.env_local.sh ]] && source ~/.env_local.sh

[[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -f "$HOME/dev/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/dev/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/dev/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/dev/google-cloud-sdk/completion.zsh.inc"; fi

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# aqua
if command -v aqua &> /dev/null; then
    source <(aqua completion zsh)
fi
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
# aqua end

# PATH=aqua/bin:$PATHを評価したあとにmise activateを実行する必要がある
# そうしないとhook-envによる環境変数差し込む処理がprojectのPATH差し込みがaquaよりあとになってしまう
if [[ -f "$HOME/.local/bin/mise" ]]; then
  eval "$($HOME/.local/bin/mise activate zsh)"
fi

if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi
# environment variables setup end ----------------------


source "$OneDrive/dotfiles/scripts/shelllib.sh"
source "$OneDrive/dotfiles/scripts/zshlib.sh"

# background image changer
configure_image_lists
set_current_image

zle -N set_background_random
bindkey '^m' set_background_random

bindkey "[C" forward-word
bindkey "[D" backward-word

# setup ghq
zle -N peco_src
bindkey '^g' peco_src

if type brew &>/dev/null; then
    # FPATH=$brew_prefix/share/zsh/site-functions:$FPATH
fi
FPATH="$OneDrive/dotfiles/zsh/completions:$FPATH"

# ----------------------
# zsh configuration
# ----------------------

# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit -i
# End of lines added by compinstall

# すべての git サブコマンド補完で ORIG_HEAD / origin を無視
zstyle ':completion:*:*:git-*:*' ignored-patterns 'ORIG_HEAD' 'origin'

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
autoload bashcompinit && bashcompinit


# ---------

end_time=$(strftime '%s%.')
echo $((end_time - start_time))

if type zprof >/dev/null 2>&1; then
    zprof | less
fi
