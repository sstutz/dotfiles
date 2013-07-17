ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]+"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]✔"
ZSH_THEME_GIT_PROMPT_PREFIX="[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]$reset_color"


function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function get_pwd() {
  print -D $PWD
}

function put_spacing() {
  local git=$(git_prompt_info)
  if [ ${#git} != 0 ]; then
    ((git=${#git} - 10))
  else
    git=0
  fi

  local termwidth
  (( termwidth = ${COLUMNS} - 5 - ${#USER}- ${#HOST} - ${#$(get_pwd)} - ${git} ))

  local spacing=""
  for i in {1..$termwidth}; do
    spacing="${spacing} " 
  done
  echo $spacing
}

function getIcon(){
	dir=${PWD##*/}
	gitBranch=$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/{\1}/')
	icon="→"
	
	if [ -f .dropbox ]; then
	    icon="☁"
	elif [ "$dir" = "Music" ]; then
	    icon="♫"
    elif [ "$gitBranch" != "" ]; then
	    icon="±"
	fi

	echo $icon;
}

function precmd() {
print -rP '%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%}%n@)%m $fg[yellow]in $(get_pwd)$(put_spacing)$(git_prompt_info)'
}
PROMPT='%{$reset_color%}$(getIcon) '