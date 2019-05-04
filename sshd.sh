#!/bin/bash
set -Ceu

sshd_sec_settings=(
    ChallengeResponseAuthentication
    PermitRootLogin
    PermitEmptyPasswords
    PasswordAuthentication
)

function rewrite_sshd() {
    local target=/etc/ssh/sshd_config
    [[ ! -e "$target.bak" ]] && sudo cp $target "$target.bak"
    for setting in "${sshd_sec_settings[@]}"; do
        if grep -q "^#\?$setting" "$target"; then
            cmd="sudo sed -i '' -E 's/^#?$setting.*/$setting no/' $target"
            echo "Execute command: $cmd"
            eval $cmd
        else
            cmd="sudo echo $setting no >> $target"
            echo "Execute command: $cmd"
            eval $cmd
        fi
    done
}

rewrite_sshd
sudo systemsetup -setremotelogin on
sudo launchctl stop com.openssh.sshd

echo $(tput setaf 2)Deploy sshd_config and starting sshd complete!. ✔︎$(tput sgr0)
