local ret_status prompt_char main_prompt

prompt_char='%%' # Need to escape the %

function main_prompt {
   # This colors the name of the package in green

   local path
   path=$(print -P %~) # Get tilde-contracted working dir
   echo "%{$fg[blue]%}$path"

}

function ret_status {
   echo "%(?:%{$fg_bold[green]%}${prompt_char}:%{$fg_bold[red]%}${prompt_char}%s)"
}

PROMPT='$(main_prompt)$(ret_status) %{$fg_bold[cyan]%}$(git_prompt_info)%{$fg_bold[blue]%}% %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[cyan]%})"
