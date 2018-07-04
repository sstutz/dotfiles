#!/usr/bin/env bash
echo "Updating/cleaning Vim plugins:"

# Thanks for greywh in #vim for this tip
vim -E -s <<EOF
    :source ~/.vim/vimrc
    :PlugInstall
    :PlugClean
    :qa
EOF

