if [ -f $(brew --prefix)/etc/brew-wrap ]; then
    source $(brew --prefix)/etc/brew-wrap
fi
# export ASDF_GOLANG_MOD_VERSION_ENABLED=true
# eval "$(direnv hook bash)"

eval "$(mise activate bash)"
export PATH="$HOME/.local/share/mise/shims:$PATH"

export PATH="$PATH:$HOME/.local/bin"
