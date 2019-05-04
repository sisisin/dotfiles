#!/bin/bash
set -Ceu

readonly work_dir=$(cd "$(dirname "$0")" && pwd)
source "$work_dir/../_lib.sh"

readonly VSC_APP_DIR="${HOME}/Library/Application Support/Code/User"

dotfiles_snnipets_dir="$VSC_FILES_DIRECTORY/snippets"
vsc_app_snnipets_dir="$VSC_APP_DIR/snippets"

find "$vsc_app_snnipets_dir" -type f | while read f; do
    cp "$f" "$dotfiles_snnipets_dir"
done
