#!/usr/local/bin/bash

if _exists btop; then
  alias cpu="btop"
  alias htop="btop"
  alias top="btop"
fi

if _exists bat; then
  export BAT_CONFIG_PATH="$DOTFILES/home/batconfig"
  alias cat='bat'
fi

if _exists trash; then
  alias rm=trash
else
  alias rm="rm -i"
fi

if _exists prettyping; then
  alias ping='prettyping --nolegend'
fi

if _exists lsd; then
  alias ls='lsd'
  alias ll='lsd -al'
  alias lsl='lsd *(@)' # only symlinks
  alias lsx='lsd *(*)' # only executables
fi

function ssh {
  if [ "$2" = "" ]; then
    conn="$1"
    sshhost=$(printf "%s" "$conn" | cut -d '@' -f2)
    if rg -U -i "^#.*Features:.*mosh.*\nHost $sshhost" "$HOME/.ssh/config" >/dev/null; then
      e_success "connecting with mosh ...\n"
      command mosh --no-init "$conn"
    else
      e_header "connecting with ssh ...\n"
      command ssh "$conn"
    fi
  else
    e_header "connecting with ssh ...\n"
    command ssh "$@"
  fi
}

# Clever thing from wincent: https://github.com/wincent/wincent/blob/main/aspects/dotfiles/files/.zsh/functions
# `git` wrapper:
#
#     - `git` with no arguments = `git status`; run `git help` to show what
#       vanilla `git` without arguments would normally show.
#     - `git root` = `cd` to repo root.
#     - `ROOT=$(git root)` = no args and stdout is not a tty; prints the root.
#     - `git root ARG...` = evals `ARG...` from the root (eg. `git root ls`).
#     - `git ARG...` = behaves just like normal `git` command.
#
function git() {
  if [ $# -eq 0 ]; then
    command git status
  elif [ "$1" = root ]; then
    shift
    local ROOT
    if [ "$(command git rev-parse --is-inside-git-dir 2>/dev/null)" = true ]; then
      if [ "$(command git rev-parse --is-bare-repository)" = true ]; then
        ROOT="$(command git rev-parse --absolute-git-dir)"
      else
        # Note: This is a good-enough, rough heuristic, which ignores
        # the possibility that GIT_DIR might be outside of the worktree;
        # see:
        # https://stackoverflow.com/a/38852055/2103996
        ROOT="$(command git rev-parse --git-dir)/.."
      fi
    else
      # Git 2.13.0 and above:
      ROOT="$(command git rev-parse --show-superproject-working-tree 2>/dev/null)"
      if [ -z "$ROOT" ]; then
        ROOT="$(command git rev-parse --show-toplevel 2>/dev/null)"
      fi
    fi
    if [ -z "$ROOT" ]; then
      ROOT="$PWD"
    fi
    if [ $# -eq 0 ]; then
      if [ -t 1 ]; then
        cd "$ROOT"
      else
        echo "$ROOT"
      fi
    else
      (cd "$ROOT" && eval "$@")
    fi
  else
    command git "$@"
  fi
}

alias youtube-dl="yt-dlp"

# more verbose fileutils
alias cp='cp -v'
alias chmod='chmod -v'
alias chown='chown -v'
alias rename='rename -v'
