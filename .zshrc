#!/usr/bin/env bash

for function in ~/.local/scripts/*; do
    if [[ -e "$function" ]]; then
        source $function
    else
        echo "$function not found"
    fi
done;

for config in ~/.zsh/*; do
    if [[ -e "$config" ]] && [[ "$config" != "$HOME/.zsh/zhistory" ]]; then
        source $config
    fi
done;

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
