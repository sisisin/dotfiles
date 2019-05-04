#!/bin/bash
set -Ceu

readonly work_dir=$(cd "$(dirname "$0")" && pwd)
source "$work_dir/_lib.sh"

cd ${DOT_FILES_DIRECTORY}

find . -type f | while read f; do
    [[ ${f} == ".DS_Store" ]] && continue
    [[ ${f} == ".git" ]] && continue
    [[ ${f} == ".gitignore" ]] && continue
    ln -snfv ${DOT_FILES_DIRECTORY}/${f} ${HOME}/${f}
done
echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
