#!/bin/bash
set -Ceu

readonly work_dir=$(cd "$(dirname "$0")" && pwd)
source "$work_dir/_lib.sh"

"$work_dir/files.sh"
"$work_dir/ssh.sh"

export DOTFILES_PATH="$HOME/Dropbox/dotfiles"
export HOMEBREW_BREWFILE=$DOTFILES_PATH/brewfile/Brewfile

# need to install java for sbt, maven, or others...
brew tap AdoptOpenJDK/openjdk
brew cask install adoptopenjdk8

brew file install
echo $(tput setaf 2)BrewFiles install complete!. ✔︎$(tput sgr0)

"$work_dir/zsh.sh"

"$work_dir/vscode.sh"

"$work_dir/mac.sh"
"$work_dir/sshd.sh"
