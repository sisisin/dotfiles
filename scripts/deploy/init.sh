#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

script_dir=$(cd "$(dirname "$0")" && pwd)
readonly script_dir

source "$script_dir/_lib.sh"
cd "${DOT_DIRECTORY}"

has() {
    type "$1" >/dev/null 2>&1
}

if has "brew"; then
    echo "$(tput setaf 2)Already installed Homebrew ✔︎$(tput sgr0)"
else
    echo "Homebrew is not installed. Please install it first."
    echo "Visit: https://brew.sh"
    exit 1
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

# echo "Installing brew-file"
# brew install rcmdnk/file/brew-file
# echo "$(tput setaf 2) installed Homebrew ✔︎$(tput sgr0)"
# echo "do 'brew file init.'"

# need to install java for sbt, maven, or others...
# brew tap AdoptOpenJDK/openjdk
# brew install adoptopenjdk8 --cask

# export HOMEBREW_BREWFILE="$DOT_DIRECTORY/files/.config/brewfile/Brewfile"
# brew file install
# echo $(tput setaf 2)BrewFiles install complete!. ✔︎$(tput sgr0)

# aqua
if has "aqua"; then
    echo "$(tput setaf 2)Already installed aqua ✔︎$(tput sgr0)"
else
    echo "Installing aqua..."
    brew install aquaproj/aqua/aqua
    echo "$(tput setaf 2)Installed aqua ✔︎$(tput sgr0)"
fi

if has "mise"; then
    echo "$(tput setaf 2)Already installed mise ✔︎$(tput sgr0)"
else
    echo "mise is not installed. Please install it first."
    echo "Visit: https://mise.jdx.dev/"
    exit 1
fi

init_macos_settings
