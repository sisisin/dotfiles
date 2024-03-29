#!/bin/bash
set -Ceu

# add zsh in standard shell
readonly zsh_path="$(brew --prefix)/bin/zsh"
if ! grep -q $zsh_path /etc/shells; then
    echo $zsh_path | sudo tee -a /etc/shells
fi

# change default shell
sudo chsh -s $zsh_path $(logname)

echo $(tput setaf 2)Update zsh setting complete!. ✔︎$(tput sgr0)
