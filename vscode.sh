#!/bin/bash
set -Ceu

readonly work_dir=$(cd "$(dirname "$0")" && pwd)
readonly VSC_APP_DIR="${HOME}/Library/Application Support/Code/User"

source "$work_dir/_lib.sh"

cd "${VSC_FILES_DIRECTORY}"

function create_symlink() {
    ln -snfv "${VSC_FILES_DIRECTORY}/keybindings.json" "${VSC_APP_DIR}/keybindings.json"
    ln -snfv "${VSC_FILES_DIRECTORY}/settings.json" "${VSC_APP_DIR}/settings.json"

    [ ! -L "${VSC_APP_DIR}/snippets" ] && [ -s "${VSC_APP_DIR}/snippets" ] && mv "${VSC_APP_DIR}/snippets" "${VSC_APP_DIR}/snippets.bak"
    ln -snfv "${VSC_FILES_DIRECTORY}/snippets" "${VSC_APP_DIR}"
}

"$DOT_DIRECTORY/bin/vsc-ext-manager" install-and-append-to-file
create_symlink
echo $(tput setaf 2)Deploy VSCode setting files complete!. ✔︎$(tput sgr0)
