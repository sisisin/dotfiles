#!/bin/bash
set -Ceu

readonly work_dir=$(cd "$(dirname "$0")" && pwd)
source "$work_dir/_lib.sh"
cd ${DOT_DIRECTORY}

has() {
    type "$1" >/dev/null 2>&1
}

if has "brew"; then
    echo "$(tput setaf 2)Already installed Homebrew ✔︎$(tput sgr0)"
else
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "$(tput setaf 2) installed Homebrew ✔︎$(tput sgr0)"
fi
if has "brew"; then
    echo "Installing brew-file"
    brew install rcmdnk/file/brew-file
    echo "$(tput setaf 2) installed Homebrew ✔︎$(tput sgr0)"
    echo "do 'brew file init.'"
fi

brew file install

if has "nvm"; then
    echo "$(tput setaf 2)Already installed nvm ✔︎$(tput sgr0)"
else
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
    echo "$(tput setaf 2) installed nvm and node ✔︎$(tput sgr0)"
fi
