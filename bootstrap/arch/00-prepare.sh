#!/usr/bin/env bash

# Dave Reisner's key
readonly REISNER_GPG=F56C0C53

if [[ $(gpg --list-keys | grep -w $REISNER_GPG) ]]; then
    info "Dave Reisners GPG Key exists"
else
    gpg --keyserver hkp://pgp.mit.edu --recv-keys $REISNER_GPG 2>/dev/null
    success "Dave Reisner's GPG Key imported!"
fi

if hash cower 2>/dev/null; then
    info "Skipping cower installation. Already installed."
else
    # Install cower as a dependency
    git clone https://aur.archlinux.org/cower.git && cd cower
    makepkg -sri --noconfirm --asdeps && cd ..
    rm -rf cower
    success "Cower successfully installed"
fi

if hash pacaur 2>/dev/null; then
    info "Skipping pacaur installation. Already installed."
else
    # Finally, install pacaur
    git clone https://aur.archlinux.org/pacaur.git && cd pacaur
    makepkg -sri --noconfirm && cd ..
    rm -rf pacaur
    success "Pacaur successfully installed"
fi
