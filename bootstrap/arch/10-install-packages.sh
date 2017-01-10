#!/usr/bin/env bash

cd packages/arch/

for group in *; do
    info "Installing packages from group $group"
    pkglist=""

    while read -r package; do
        pkglist+=" $package"
    done <<< $(grep -vE '^(\s*$|#)' "$group")

 #   pacaur -S --noconfirm --noedit $pkglist
done

