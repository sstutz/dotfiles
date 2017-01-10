#!/usr/bin/env bash
echo "Arch Linux"
for script in $BOOTSTRAP_ROOT/bootstrap/arch/*.sh; do
    # Make sure each script starts in the same place
    cd "$BOOTSTRAP_ROOT"

    source "$script"
done


# Install AUR Helper

# Install all packages

