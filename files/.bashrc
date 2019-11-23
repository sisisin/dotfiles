if [ -f $(brew --prefix)/etc/brew-wrap ]; then
    source $(brew --prefix)/etc/brew-wrap
fi

hlcp() {
    pbpaste | highlight $* -O rtf -K 24 | pbcopy
}
hlcpf() {
    pbpaste | highlight $* -O rtf -K 24 -s Breeze | pbcopy
}
