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
