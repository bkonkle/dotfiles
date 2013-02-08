function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function virtualenv_info {
    if [[ -n $VIRTUAL_ENV ]]; then
      echo -n "on $fg[blue]`basename $VIRTUAL_ENV`$reset_color "
    fi
}

function prompt_chars {
    if [ $(git symbolic-ref HEAD 2> /dev/null) ]; then
        echo '±'
    elif [ $(hg root &> /dev/null) ]; then
        echo '☿'
    elif [[ -d .svn ]]; then
        echo '○'
    else
        echo '$'
    fi
}

# Get the status of the working tree
unset git_prompt_status # Delete the original function
function git_prompt_status {
  INDEX=$(git status --porcelain 2> /dev/null)
  STATUS=""
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
    STATUS="$fg[red]?$reset_color$STATUS"
  fi
  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    STATUS="$fg[green]A$reset_color$STATUS"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    STATUS="$fg[green]M$reset_color$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    STATUS="$fg[red]M$reset_color$STATUS"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    STATUS="$fg[green]A$reset_color$fg[red]M$reset_color$STATUS"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    STATUS="$fg[red]T$reset_color$STATUS"
  fi
  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
    STATUS="$fg[green]R$reset_color$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    STATUS="$fg[red]D$reset_color$STATUS"
  elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
    STATUS="$fg[green]A$reset_color$fg[red]D$reset_color$STATUS"
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$fg[red]U$reset_color$STATUS"
  fi
  if [ -n "$STATUS" ]; then
    echo "[$STATUS]"
  fi
}

PROMPT='
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}%{$(collapse_pwd)%}%{$reset_color%} $(virtualenv_info)$(git_prompt_info)$(git_prompt_status)$(git_prompt_ahead)
$(prompt_chars) '

ZSH_THEME_GIT_PROMPT_PREFIX="branch $fg[cyan]"
ZSH_THEME_GIT_PROMPT_SUFFIX="$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_AHEAD="$fg[green]»$reset_color"
