# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="devbox"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# add folder completion for ".."
zstyle ':completion:*' special-dirs true

# if files were numerical, sort it this way :P
setopt NUMERIC_GLOB_SORT

# Enable extended globbing
setopt EXTENDED_GLOB

# verbose output for cp and rm
for c in cp rm rmdir; do
    alias $c="$c -v"
done

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi


for file in ~/.{exports,aliases,zshrc.local}; do
    [ -r "$file" ] && source "$file"
done

unset file