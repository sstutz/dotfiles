#!/usr/bin/env bash
stow_help() {
    echo "SYNOPSIS:"
    echo "    dotfiles stow [-D|-S]"
    echo
    echo "OPTIONS"
    echo "    -S, (default)		creates symlinks to dotfiles (Default)"
    echo "    -D, cleanup, purge	removes a symlink"
    echo
    echo "Stow determines what directories the symlinks go in"
    echo "by parsing the file \".stowtarget\""
}


stow_packages() {
    cd "${__dir}/stowable"

    case $1 in
        cleanup|purge|-D)
            local action="Deleting"
            local flag="-D"
            ;;
        ""|-S)
            local action="Stowing"
            local flag="-S"
            ;;
        *)
            stow_help; exit 0;;
    esac

    for package in */; do
        local lockfile="$package/.stowlock"
        if [[ -f $lockfile && $flag == "-S" ]]; then
            local action="Restowing"
            local flag="-R"
        fi

        stow_package
    done
}


stow_package() {
    targetfile="$package/.stowtarget"
    target=$([[ -f $targetfile ]] && echo $(eval echo $(<$targetfile)) || echo "$HOME/.config/$package")

    if [[ ! -d "$target" ]]; then
        mkdir -p "$target"
    fi

    info "$action package '$package'" && touch "$lockfile"

    # could get real ugly real quick, maybe introducing .stowignore?
    local ignores="--ignore=.netrwhist --ignore=themes --ignore=.stowlock --ignore=.stowtarget"
    /usr/bin/stow --target="$target" $flag $package $ignores

    if [[ $flag == "-D" ]]; then
        rm "$lockfile"
    fi
}
