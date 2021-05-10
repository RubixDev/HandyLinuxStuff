# ZSH Theme - Based on the lukerandall theme

function my_git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  GIT_STATUS=$(git_prompt_status)
  [[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

local name='%{$fg[green]%}%n%{$reset_color%}@'
local gitpinfo='$(my_git_prompt_info)%{$reset_color%}'
local error='%(?..%{$fg[red]%}[%{$fg_bold[red]%}%?%{$reset_color%}%{$fg[red]%}]%{$reset_color%})'


_fishy_collapsed_wd() {
  local i pwd
  pwd=("${(s:/:)PWD/#$HOME/~}")
  if (( $#pwd > 1 )); then
    for i in {1..$(($#pwd-1))}; do
      if [[ "$pwd[$i]" = .* ]]; then
        pwd[$i]="${${pwd[$i]}[1,2]}"
      else
        pwd[$i]="${${pwd[$i]}[1]}"
      fi
    done
  fi
  echo "${(j:/:)pwd}"
}


# Test to see if user is root
if [[ $EUID == 0 ]]; then
  local dir='%{$fg[red]%}$(_fishy_collapsed_wd)%{$reset_color%} '
	local arrow='# '
else
  local dir='%{$fg[green]%}$(_fishy_collapsed_wd)%{$reset_color%} '
	local arrow='%B»%b '
fi

local host='%{$fg[yellow]%}%m '

PROMPT=$name$host$dir$gitpinfo$error$arrow

# Shows time at end of prompt line
#RPROMPT='%t'

# Shows return arrow when output does not end in newline
PROMPT_EOL_MARK='↵ '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=") %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"

