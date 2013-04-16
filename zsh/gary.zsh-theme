setopt prompt_subst
autoload colors
colors

autoload -U add-zsh-hook
autoload -Uz vcs_info

if [[ $TERM = *256color* || $TERM = *rxvt* ]]; then
    turquoise="%F{81}"
    orange="%F{166}"
    purple="%F{135}"
    hotpink="%F{161}"
    limegreen="%F{118}"
    baseblue="%F{021}"
    yellow="%F{184}"
    grey="%F{246}"
    lightpurple="%F{141}"
    otherblue="%F{027}"
    lighterblue="%F{004}"
    moarblue="%F{039}"
    blueish="%F{038}"
    red="%F{160}"
    green="%F{118}"
    dark_green="%F{114}"
    brownish="%F{130}"
else
    turquoise="$fg[cyan]"
    orange="$fg[yellow]"
    purple="$fg[magenta]"
    hotpink="$fg[red]"
    limegreen="$fg[green]"
fi

PR_RST="%{${reset_color}%}"

function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo " %{$fg_bold[red]%}(ssh)"
  fi
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo "%{$hotpink%}►" && return
    echo "%{$turquoise%}►"
}
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}
function left_bracket {
    echo "%{$baseblue%}╭"
}
function right_bracket {
    # echo "%{$baseblue%}╮"
}
function left_lower_bracket {
    echo "%{$baseblue%}╰"
}
# ╰╭╮┖┎┕┍┗┏
function username {
    echo "%{[01m%}%{$lighterblue%}%n%{[22m%}"
}

PROMPT=$'
$(left_bracket) $(username)%{$reset_color%} ¬ %{$yellow%}$(box_name)%{$reset_color%} · %{$moarblue%}%~%{$reset_color%} $(right_bracket)%{$reset_color%} $(battery_pct_prompt)
$(left_lower_bracket)$(prompt_char) '

RPROMPT='$(git_prompt_info)%{$reset_color%} $(git_prompt_status)%{$reset_color%}$(git_time_since_commit)'

ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$red%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$hotpink%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$lightpurple%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$grey%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$yellow%}⋆%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$brownish%}♻"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$green%}⁇"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$green%}✔"
ZSH_THEME_GIT_PROMPT_ADDED="%{$dark_green%}✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$blueish%}⚒"
ZSH_THEME_GIT_PROMPT_DELETED="%{$red%}✘"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$orange%}☇"
ZSH_THEME_GIT_PROMPT_UNMERGED="?!?!"

preexec () {
    echo ""
}

# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function git_time_since_commit() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Only proceed if there is actually a commit.
        if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
            # Get the last commit.
            last_commit=`git log --pretty=format:'%at' -1 2> /dev/null`
            now=`date +%s`
            seconds_since_last_commit=$((now-last_commit))

            # Totals
            MINUTES=$((seconds_since_last_commit / 60))
            HOURS=$((seconds_since_last_commit/3600))
           
            # Sub-hours and sub-minutes
            DAYS=$((seconds_since_last_commit / 86400))
            SUB_HOURS=$((HOURS % 24))
            SUB_MINUTES=$((MINUTES % 60))
            
            if [[ -n $(git status -s 2> /dev/null) ]]; then
                if [ "$MINUTES" -gt 30 ]; then
                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
                elif [ "$MINUTES" -gt 10 ]; then
                    COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
                else
                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
                fi
            else
                COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            fi

            if [ "$HOURS" -gt 24 ]; then
                echo " $COLOR${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m%{$reset_color%}"
            elif [ "$MINUTES" -gt 60 ]; then
                echo " $COLOR${HOURS}h${SUB_MINUTES}m%{$reset_color%}"
            else
                echo " $COLOR${MINUTES}m%{$reset_color%}"
            fi
        else
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            echo " $COLOR~"
        fi
    fi
}