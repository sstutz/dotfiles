#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
shopt -s nullglob


# Exit immediately if a simple command exits with a non-zero status
set -e


# Include helpers
source "$(dirname $0)/functions/helpers.sh";
source "$(dirname $0)/stow.sh";


##
# Variables
#
dotdir="$HOME/dotfiles";
olddir="$dotdir/dotfiles_old";
cmds=('zsh' 'git' 'xsel' 'pastebinit' 'toilet' 'ctags' 'ag' 'stow');
protected=('functions' 'dotfiles_old');


##
# lets see if there is already a backup folder, if not we'll create it
#
create_backup_folder() {
    if [[ ! -d "$olddir" ]]; then
        mkdir -p "$olddir"
        info "Created backup folder for old dotfiles in '$olddir'"
    fi
}


##
# Enable git submodules
#
init_git_submodules() {
    cd "$dotdir";
    if git submodule init > /dev/null 2>&1; then
        success "Initialized all submodules.";
    else
        die "Could not initialize git submodules"
    fi
}


##
# Update git submodules
#
update_git_submodules() {
    cd "$dotdir";
    if git submodule update; then
        success "Updated all submodules."
    else
        die "Could not update submodules.";
    fi;
}


##
# Make sure zsh is the default shell
#
set_zsh_default() {
    if [[ $SHELL != */zsh ]]; then
        info "Password is required to change the defaut shell."
        chsh -s $(which zsh)
        success "Changed the default shell to ZSH"
    else
        info "ZSH is already the default."
    fi
}


##
# Installs devboxs zsh tehem
#
install_zsh_theme() {
    if [[ -d "$HOME/.oh-my-zsh/themes/" ]]; then
        if [[ ! -f "$HOME/.oh-my-zsh/themes/devbox.zsh-theme" ]]; then
            ln -s "$dotdir/zsh/devbox.zsh-theme" "$dotdir/zsh/.oh-my-zsh/themes/devbox.zsh-theme";
            success "Installed new ZSH theme."
        else
            info "Devbox theme for ZSH already installed."
        fi
    fi
}


##
# Install Vundle modules
#
install_vundles() {
    user "Do you want to install all Vundle bundles? (y or n)"
    printf " [${yellow} ?? ${nc}] ";
    read -n 1 action;
    echo ''
    if [[ "$action" == "y" ]]; then
        if vim -u ~/.vimrc.bundles +BundleInstall +qa; then
            success "all bundles are installed!";
        else
            warn "Could not install Vundle bundles."
        fi;
    fi;
}


##
# Exclude the custom theme from zsh's submodule
# Since we cannot modify submodules, ignore file nor push a custom theme to
# the repository, we will simply tell git to ignore that file completely!
#
exclude_zsh_theme() {
    local excludeFile="$dotdir/.git/modules/zsh/.oh-my-zsh/info/exclude";
    local themeFile="themes/devbox.zsh-theme"

    if grep -Fxq "$themeFile" "$excludeFile"; then
        info "Devbox theme already added to git's exclude file"
    else
        echo "$themeFile" >> "$excludeFile"
        success "Added '$themeFile' to git exclude!"
    fi
}


##
# Make sure all required software is available, otherwise abort.
#
install_dependencies(){
    for cmd in "${cmds[@]}"; do
        command -v $cmd >/dev/null 2>&1 || {
            warn "$cmd is not installed but required. Aborting :(";

            if [[ -e "/etc/debian_version" ]]; then
                info "but you might want to try 'sudo apt-get install $cmd'";
            fi

            if [[ -e "/etc/redhat-release" ]]; then
                info "but you might want to try 'sudo yum install $cmd'";
            fi

            if [[ -e "/etc/arch-release" ]]; then
                info "but you might want to try 'sudo pacman -S $cmd'";
            fi

            exit 1;
        }
    done;
}


##
# if a file is already available, we'll move it into a backup folder in $HOME.
#
install_dotfiles() {

    cd "$dotdir";

    backup_all=false

    overwrite_all=false

    skip_all=false

    # Create a temporary associative array
    declare -A tmp;

    # fill the array with all protected files
    for p in "${protected[@]}"; do
        tmp["$dotdir/$p"]=1;
    done;

    for path in "$dotdir"/*; do
        pkg=$(basename $path)
        if ((tmp[$path])) || [[ ! -d "$path" ]]; then
            continue
        fi


        if [[ ! -e `package_target "$pkg"` ]]; then
            indexed_stow "$pkg"
            continue
        fi;

        backup=false

        overwrite=false

        skip=false

        if [[ $overwrite_all = false && $backup_all = false && $skip_all = false ]]; then

            user "File '$target' already exists, what do you want to do?"
            user "[B]ackup all, [o]verwrite, [O]verwrite all, [b]ackup, [s]kip, [S]kip all?"

            strike=0;

            action=null;

            until [[ "$action" =~ [BoObsS] ]]; do

                if [[ "$strike" == 3 ]]; then
                    die "Ok .. no more bash for you!";
                fi

                printf " [${yellow} ?? ${nc}] ";
                read -n 1 action;
                echo ''

                case "$action" in
                    "B" ) backup_all=true;;
                    "o" ) overwrite=true;;
                    "O" ) overwrite_all=true;;
                    "b" ) backup=true;;
                    "s" ) skip=true;;
                    "S" ) skip_all=true;;
                    * )
                        warn "Please enter a valid option.";
                        ((strike++));
                    ;;
                esac;

            done;
        fi;


        if [[ "$overwrite" == true || "$overwrite_all" == true ]]; then
            rm -rf $target
            info "removed $target"
        fi


        if [[ "$backup" == true || "$backup_all" == true ]]; then
            mv "$target" "$olddir/${file##*/}"
            info "Created a backup for '${file##*/}' in '$olddir/${file##*/}'"
        fi


        if [[ "$skip" == false && "$skip_all" == false ]]; then
            indexed_stow "$file"
        else
            info "'$target' was skipped."
        fi;
    done
}

main(){
    install_dependencies;

    init_git_submodules;

    update_git_submodules;

    create_backup_folder;

    set_zsh_default;

    install_dotfiles;

    install_zsh_theme;

    exclude_zsh_theme;

    install_vundles;
}

main;

success "All done, enjoy!"
