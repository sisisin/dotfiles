#!/bin/bash
set -Ceu

readonly work_dir=$(cd "$(dirname "$0")" && pwd)
source "$work_dir/_lib.sh"
cd "${DOT_DIRECTORY}"

has() {
    type "$1" >/dev/null 2>&1
}

if has "brew"; then
    echo "$(tput setaf 2)Already installed Homebrew ✔︎$(tput sgr0)"
else
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    echo "$(tput setaf 2) installed Homebrew ✔︎$(tput sgr0)"
fi
if has "brew"; then
    echo "Installing brew-file"
    brew install rcmdnk/file/brew-file
    echo "$(tput setaf 2) installed Homebrew ✔︎$(tput sgr0)"
    echo "do 'brew file init.'"
fi

if has "gg"; then
    echo "$(tput setaf 2)Already installed gg ✔︎$(tput sgr0)"
else
    curl -fsSL git.io/gg.sh | bash
fi

if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
    . $HOME/.asdf/asdf.sh
fi

# need to install java for sbt, maven, or others...
brew tap AdoptOpenJDK/openjdk
brew cask install adoptopenjdk8

export HOMEBREW_BREWFILE="$DOT_DIRECTORY/files/.config/brewfile/Brewfile"
brew file install
echo $(tput setaf 2)BrewFiles install complete!. ✔︎$(tput sgr0)

# NeoBundle
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh >install.sh
sh ./install.sh
vim +NeoBundleInstall +qall
rm ./install.sh
