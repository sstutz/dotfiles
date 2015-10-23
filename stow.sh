#!/bin/bash
##
# Display Help
#
display_help() {
    echo "SYNOPSIS:"
    echo "    stow.sh [-D|-S|-R]  <package1> [<package2> <package3> ...]"
    echo
    echo "OPTIONS"
    echo "    -S   creates symlinks to dotfiles (Default)"
    echo "    -D   removes a symlink"
    echo "    -R   removes and then re-creates symlinks"
    echo
    echo "Stow determines what directories the symlinks go in"
    echo "by parsing the file \"index\""
}


##
# Print target for given package
#
package_target(){
        if [[ -z "$1" ]]; then
            echo "Error: no package provided"
            return 1
        fi

        local map=(`grep "^$1:" index`)
        if [[ -z "$map" ]]; then
            echo "Error: \"$package\" not found in index"
            return 1
        fi

        echo "${map[1]}"
}


##
# Helper function to make use of index files for targets
#
indexed_stow() {
    local flag="--stow"

    # Reset in case getopts has been used previously in the shell.
    OPTIND=1

    while getopts "RDSnh?:" opt; do
        case "$opt" in
        R)      flag="--restow";;
        D)      flag="--delete";;
        S)      flag="--stow";;
        n)      fake="--no";;
        h|\?)   display_help; return 1;;
        "")     display_help; return 1;;
        esac
    done
    shift $((OPTIND-1))

    for package in "$@"; do

        if [[ ! -d "$package" ]]; then
            echo "Error: directory '$package' not found"
            return 1
        fi

        target=`package_target "$package"`
        ignores="--ignore=.netrwhist --ignore=devbox.zsh-theme"
        eval "stow $fake --verbose -t $target $flag $package $ignores"
    done
}

indexed_stow "$@"
