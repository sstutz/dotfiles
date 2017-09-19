#!/usr/bin/env bash

for function in ~/.config/dotfiles/scripts/*; do
    if [[ -e "$function" ]]; then
        . $function
    else
        echo "$function not found"
    fi
done;

for config in ~/.zsh/*; do
    if [[ -e "$config" ]] && [[ "$config" != "$HOME/.zsh/zhistory" ]]; then
        . $config
    fi
done;

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
