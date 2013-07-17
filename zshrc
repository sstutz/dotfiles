# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="devbox"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# add folder completion for ".."
zstyle ':completion:*' special-dirs true

export EDITOR="vim"

# if files were numerical, sort it this way :P
setopt NUMERIC_GLOB_SORT

# verbose output for cp and rm
for c in cp rm rmdir; do
    alias $c="$c -v"
done

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

export PATH=$PATH:/home/$USER/.cabal/bin:/home/$USER/.local/bin

# prevent duplicate entries in the history and does not list commands with a preceding whitespace
export HISTCONTROL=ignoreboth

# Enable extended globbing
setopt EXTENDED_GLOB

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local