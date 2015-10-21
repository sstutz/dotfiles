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

# but when pattern matching fails, simply use the command as is
setopt no_nomatch

# History settings
HISTSIZE=5000
SAVEHIST="$HISTSIZE"

setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_verify
setopt append_history

# don't kill background processes when closing the shell
setopt nohup

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

for file in ~/.{exports,aliases,functions,zshrc.local}; do
    [ -r "$file" ] && source "$file"
done

unset file
