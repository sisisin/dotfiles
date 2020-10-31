#!/bin/bash
set -Ceu

readonly work_dir=$(cd "$(dirname "$0")" && pwd)
source "$work_dir/_lib.sh"

"$work_dir/files.sh"
"$work_dir/ssh.sh"
"$work_dir/zsh.sh"
# "$work_dir/vscode.sh"
"$work_dir/mac.sh"
"$work_dir/sshd.sh"
