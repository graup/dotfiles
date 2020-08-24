[ -r ~/.bash_alias ] && source ~/.bash_alias

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export GOPATH="/Users/paulgrau/go"
export PATH="$GOPATH/bin:$PATH"

shopt -s checkwinsize

bind Space:magic-space

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

RED_CLR="\[\e[0;31m\]"
GRN_CLR="\[\e[0;32m\]"
YLW_CLR="\[\e[0;33m\]"
BLU_CLR="\[\e[0;34m\]"
PPL_CLR="\[\e[0;35m\]"
CYN_CLR="\[\e[0;36m\]"
WHT_CLR="\[\e[0;37m\]"
NON_CLR="\[\e[0m\]"

PS1_CLR="$BLU_CLR"

export FAILURE_CHAR="✘"
export SUCCESS_CHAR="✔"
export PROMPT_CHAR="⚡️"
export PROMPT_CHAR="➜"
export PROMPT_CONT="."

export PS1="${PS1_CLR}$PROMPT_CHAR $NON_CLR"
export PS2="${PS1_CLR}$PROMPT_CONT $NON_CLR "

__prompt_colour() {
   # Doesn't work because root shell doesn't run this file.
   if [ $(id -u) -eq 0 ]; then
       echo $RED_CLR
   else
       echo $GRN_CLR
   fi
}

__prompt_venv() {
   if [[ $VIRTUAL_ENV != '' ]]; then
       echo "$YLW_CLR($(basename "$VIRTUAL_ENV"))$NON_CLR "
   fi
}

__prompt_status() {
   if test "$?" -eq 0
   then
       echo "$GRN_CLR$SUCCESS_CHAR$NON_CLR"
   else
       echo "$RED_CLR$FAILURE_CHAR$NON_CLR"
   fi
}

__prompt_git() {
   branchname="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
   [[ ! -z "$branchname" ]] && echo " $YLW_CLR[$branchname]$NON_CLR"
}

__prompt() {
   export PS1="$(__prompt_status)\n$(__prompt_venv)$(__prompt_colour)\u$NON_CLR@$GRN_CLR\h$NON_CLR$(__prompt_git) $PPL_CLR\w$NON_CLR$(__prompt_colour) $NON_CLR"
   export PS2="$(__prompt_colour)$PROMPT_CONT $NON_CLR "

   # Set the title (in iTerm 2)
   reponame="$(git config --local remote.origin.url 2>/dev/null |sed -n 's#.*/\([^.]*\).*$#\1#p')"
   [[ ! -z "$reponame" ]] && echo -ne "\033]0;$reponame\007"
}

export PROMPT_COMMAND=__prompt

if [ -r /etc/bash_completion ]; then
   . /etc/bash_completion
fi

LS_COLORS=$LS_COLORS:'di=0;32:' ; export LS_COLORS
export PATH="$HOME/.cargo/bin:$PATH"
