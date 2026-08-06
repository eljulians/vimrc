#!/usr/bin/env bash
#
# install_nvim.sh -- wire this repo's neovim config into place, declaratively.
#
# Symlinks ~/.config/nvim -> <repo>/nvim so neovim loads the tracked config.
# Idempotent and safe to re-run; backs up any pre-existing real config.

set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
nvim_src="${repo_dir}/nvim"
nvim_dest="${XDG_CONFIG_HOME:-${HOME}/.config}/nvim"

mkdir -p "$(dirname "${nvim_dest}")"

# Preserve any existing non-symlink config instead of clobbering it.
if [[ -e "${nvim_dest}" && ! -L "${nvim_dest}" ]]; then
    backup="${nvim_dest}.backup.$(date +%Y%m%d%H%M%S)"
    printf 'Existing config at %s -> backing up to %s\n' "${nvim_dest}" "${backup}"
    mv "${nvim_dest}" "${backup}"
fi

ln -sfn "${nvim_src}" "${nvim_dest}"
printf 'Linked %s -> %s\n' "${nvim_dest}" "${nvim_src}"
