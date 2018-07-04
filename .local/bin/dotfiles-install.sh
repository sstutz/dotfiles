#!/usr/bin/env sh

DOTFILES_REPO="git@github.com:sstutz/dotfiles.git"
DOTFILES_DIR="$HOME/.config/dotfiles2"
BACKUP_DIR="$HOME/.config/dotfiles-org"

if [[ ! -x /usr/bin/git ]]; then
    echo "Please install git"
    exit 1
fi

config() {
   /usr/bin/git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" $@
}

backup_original_configuration() {
    mkdir -p "$BACKUP_DIR"
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} "$BACKUP_DIR/"{}
    echo "Original configuration stored in $BACKUP_DIR"
}

clone_dotfiles() {
    if [[ ! -d "$DOTFILES_DIR" ]]; then
        mkdir -p " $DOTFILES_DIR"
    fi
    if git clone --bare "$DOTFILES_REPO" "$DOTFILES_DIR" >/dev/null 2>&1; then
        echo "installed dotfiles to $DOTFILES_DIR"
    else
        echo "Dotfiles already installed in $DOTFILES_DIR"
        exit 0
    fi
}

checkout_dotfiles() {
    if ! config checkout; then
        backup_original_configuration
    fi
    if ! config checkout; then
        echo "Unknown error"
        exit 1
    fi
    echo "Checked out config.";
}

hide_untracked_files() {
    config config status.showUntrackedFiles no
}

clone_dotfiles
checkout_dotfiles
hide_untracked_files
