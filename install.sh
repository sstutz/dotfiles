#!/usr/bin/env bash

# expands non-matching globs to zero arguments, rather than to themselves
shopt -s nullglob

#
# Set magic variables for current file & dir
#
readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly __file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
readonly __base="$(basename ${__file} .sh)"
readonly __root="$(cd "$(dirname "${__dir}")" && pwd)"
action="${1:-}"
flag="${2:-}"

# some functions to make my life easier
source "${__dir}/scripts/00_helpers.sh"
source "${__dir}/bootstrap/50-stow.sh"

bootstrap() {
    if [[ -e "/etc/debian_version" ]]; then
        source "environment/ubuntu.sh"

    elif [[ -e "/etc/arch-release" ]]; then
        source "environment/arch.sh"

    else
        warn "Chances are this script will break."
        exit 1
    fi

    for script in "${__dir}/bootstrap/*.sh"; do
        cd "${__dir}"
        source "$script"
    done
}


print_help() {
    echo "bootstrap or stow"
    exit 0;
}


main() {
    case "$action" in
        "stow")
            stow_packages "${flag}";;
        "bootstrap")
            bootstrap;;
        *)
            print_help;;
    esac
}

main;
