#!/usr/bin/env bash

for config in ~/.zsh/*; do
    if [[ -e "$config" ]]; then
        . $config
    else
        echo "$config not found"
    fi
done;

for function in ~/dotfiles/functions/*; do
    if [[ -e "$function" ]]; then
        . $function
    else
        echo "$function not found"
    fi
done;

