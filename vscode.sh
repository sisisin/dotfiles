#!/bin/bash
VSC_APP_DIR="${HOME}/Library/Application Support/Code/User"
VSC_FILES_DIR="${HOME}/dotfiles/vscode"
cd ${VSC_FILES_DIR}

find . -type f | while read f
do
  [[ ${f} = ".DS_Store" ]] && continue
  ln -snfv "${VSC_FILES_DIR}/${f}" "${VSC_APP_DIR}/${f}"
done
echo $(tput setaf 2)Deploy VSCode setting files complete!. ✔︎$(tput sgr0)
