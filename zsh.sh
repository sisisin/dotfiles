#!/bin/bash
set -Ceu

# add zsh in standard shell
readonly zsh_path=/usr/local/bin/zsh
if ! grep -q $zsh_path /etc/shells; then
    sudo echo $zsh_path >>/etc/shells
fi

# change default shell
sudo chsh -s /usr/local/bin/zsh $(logname)

echo $(tput setaf 2)Update zsh setting complete!. ✔︎$(tput sgr0)
