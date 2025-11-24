#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

script_dir=$(cd "$(dirname "$0")" && pwd)
readonly script_dir

source "$script_dir/_lib.sh"

deploy_files
deploy_ssh_configs

