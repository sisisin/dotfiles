#!/bin/bash
set -Ceu

readonly work_dir=$(cd "$(dirname "$0")" && pwd)
source "$work_dir/_lib.sh"

"$work_dir/scripts/get_new_snippets.sh"

readonly VSC_APP_DIR="${HOME}/Library/Application Support/Code/User"
cd ${VSC_FILES_DIRECTORY}

find . -type f | while read f; do
    [[ ${f} == ".DS_Store" ]] && continue
    [[ ${f} == ".git" ]] && continue
    [[ ${f} == ".gitignore" ]] && continue
    ln -snfv "${VSC_FILES_DIRECTORY}/${f}" "${VSC_APP_DIR}/${f}"
done
echo $(tput setaf 2)Deploy VSCode setting files complete!. ✔︎$(tput sgr0)
