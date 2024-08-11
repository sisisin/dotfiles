#!/bin/bash
set -Ceu

cd ~/.ssh

# for certbot
readonly local_key=local_id_rsa
if [[ ! -e $local_key ]]; then
    ssh-keygen -t rsa -N "" -f $local_key
    chmod 600 $local_key
fi

if grep -qxF "$(cat ~/.ssh/$local_key.pub)" ~/.ssh/authorized_keys; then
    echo "Public key already exists in authorized_keys"
else
    cat ~/.ssh/$local_key.pub >>~/.ssh/authorized_keys
    echo "Public key added to authorized_keys"
fi

echo $(tput setaf 2)Generate ssh keys complete!. ✔︎$(tput sgr0)
