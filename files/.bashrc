if [ -f $(brew --prefix)/etc/brew-wrap ]; then
    source $(brew --prefix)/etc/brew-wrap
fi

export NODE_BINARY=/opt/homebrew/opt/asdf/shims/node

# # runtime version manager
export ASDF_DATA_DIR="$(brew --prefix asdf)/"
[[ -f "$ASDF_DATA_DIR/asdf.sh" ]] && . "$ASDF_DATA_DIR/asdf.sh"

eval "$(direnv hook bash)"
