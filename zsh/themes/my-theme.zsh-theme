local ret_status prompt_char main_prompt ns_prompt hn_prompt

prompt_char='%%' # Need to escape the %

function main_prompt {
   # This colors the name of the package in green

   local path parts
   path=$(print -P %~) # Get tilde-contracted working dir
   # if [[ $path =~ "^/src/" ]]; then
   #    parts=( ${(@s,/,)path} ) # split on slashes
   #    if (( ${#parts} > 1 )); then
   #       parts[2]="%{$fg[green]%}${parts[2]}%{$fg[blue]%}" # Package name in green
   #       path=/${(j,/,)parts} # Join with slashes
   #    fi
   # fi
   echo "%{$fg[blue]%}$path"

}

# function ns_prompt {
#    # If we are in a namespace, show the namespace name in yellow
#    if [ -n "$NS" ]; then
#       echo " %{$fg[yellow]%}(${NS#+})"
#    else
#       echo ""
#    fi
# }

# function hn_prompt {
#    if [ -z "$WP" ]; then
#       echo "(%{$fg[red]%}`hostname | cut -d. -f1`%{$reset_color%}) "
#    else
#       echo ""
#    fi
# }

function ret_status {
   echo "%(?:%{$fg_bold[green]%}${prompt_char}:%{$fg_bold[red]%}${prompt_char}%s)"
}

PROMPT='$(main_prompt)$(ret_status) %{$fg_bold[cyan]%}$(git_prompt_info)%{$fg_bold[blue]%}% %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[cyan]%})"
