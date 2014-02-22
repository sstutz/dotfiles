#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
shopt -s nullglob

# Exit immediately if a simple command exits with a non-zero status
set -e

##
# Variables
#
dotdir="$HOME/dotfiles";
olddir="$dotdir/dotfiles_old/";
cmds=('zsh' 'git' 'xsel' 'pastebinit');
protected=('README.md' 'install.sh' 'devbox.zsh-theme');
nc="$(tput sgr0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"

##
# warn: Print a message to stderr.
# Usage: warn "message"
#
warn() {
  printf " [${red}Warn${nc}] %s\n" "$1" >&2
}


##
# success: Print a message to stdout.
# Usage: success "message"
#
success () {
  printf " [${green} OK ${nc}] %s\n" "$1"
}


##
# success: Print a info message to stdout.
# Usage: info "message"
#
info() {
    printf " [${blue} .. ${nc}] %s\n" "$1"
}


##
# success: Print a info message to stdout.
# Usage: info "message"
#
user() {
    printf " [${yellow} ?? ${nc}] %s\n" "$1"
}



##
# die (simple version): Print a message to stderr
# and exit with the exit status of the most recent
# command.
# Usage: some_command || die "message"
#
die() {
  local st="$?"
  warn "$1"
  exit "$st"
}


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
    if git submodule init; then
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
# Pulls origin master for every git submodule
#
upgrade_git_submodules() {
    git submodule foreach git pull origin master;
    success "Updated all modules to origin master"
}


##
# Make sure zsh is the default shell
#
set_zsh_default() {
    if [[ $SHELL != */zsh ]]; then
        info "Password is required to change the defaut shell."
        chsh -s $(which zsh)
        success "Changed the default shell to ZSH"
    fi
}


##
# Installs devboxs zsh tehem
#
install_zsh_theme() {
    if [[ -d "$HOME/.oh-my-zsh/themes/" ]]; then
        if [[ ! -f "$HOME/.oh-my-zsh/themes/devbox.zsh-theme" ]]; then
            ln -s "$dotdir/devbox.zsh-theme" "$dotdir/oh-my-zsh/themes/devbox.zsh-theme";
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
# Create all the symbolic links.
#
create_symlinks() {
    ln -s  "$1" "$2"
    success "Created new symlink '$1' -> '$2'"
}


##
# Exclude the custom theme from zsh's submodule
# Since we cant modify the submodules ignore file nor push a custom theme to
# the repository, we will simply tell git to ignore that file completely!
#
exlcude_zsh_theme() {
    local excludeFile="$dotdir/.git/modules/oh-my-zsh/info/exclude";
    local themeFile="themes/devbox.zsh-theme"

    if grep -Fxq "$themeFile" "$excludeFile"
    then
        info "Devbox theme already added to git's exclude file"
    else
        echo "$themeFile" >> "$excludeFile"
        success "Added '$themeFile' to git exclude!"
    fi
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
    for file in "${protected[@]}"; do
        tmp["$dotdir/$file"]=1;
    done;

    for file in "$dotdir"/*; do

        if ((!tmp[$file])); then
            target="$HOME/.${file##*/}";

            if [[ -e "$target" ]]; then

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
                            die "Ok if you can't decide, no more bash for you!";
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
                    create_symlinks "$file" "$target"
                else
                    info "'$target' was skipped."
                fi;


            else
                create_symlinks "$file" "$target"
            fi;
        fi;
    done
}


main(){

    ##
    # Make sure all required software is available, otherwise abort.
    #
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

    init_git_submodules;

    update_git_submodules;

#    upgrade_git_submodules;

    create_backup_folder;

    set_zsh_default;

    install_dotfiles;

    install_zsh_theme;

    exlcude_zsh_theme;

    install_vundles;
}

main;

success "All done, enjoy!"
