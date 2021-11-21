#!/bin/bash
set -Ceu

cd ~/.ssh
readonly github_key=github_id_rsa
if [[ ! -e $github_key ]]; then
    ssh-keygen -t rsa -C azsisisin@gmail.com -N "" -f $github_key
    chmod 600 $github_key
    cat "$github_key.pub" | pbcopy
    open https://github.com/settings/ssh/new
fi

echo $(tput setaf 2)Generate ssh keys complete!. ✔︎$(tput sgr0)
