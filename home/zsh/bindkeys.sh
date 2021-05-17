#!/bin/bash

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

bindkey -e

# bindkey '^U' backward-kill-line
# bindkey "^[_" redo
# bindkey '^[^?' backward-kill-word
# bindkey '^W' backward-kill-word
# bindkey '^?' backward-delete-char

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${terminfo[kcuu1]}" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search

  bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${terminfo[kcud1]}" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search

  bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# This inserts a tab after completing a redirect.
# (Source: http://www.zsh.org/mla/users/2006/msg00690.html)
self-insert-redir() {
integer l=$#LBUFFER
zle self-insert
(( $l >= $#LBUFFER )) && LBUFFER[-1]=" $LBUFFER[-1]"
}
zle -N self-insert-redir
for op in \| \< \> \& ; do
  bindkey "$op" self-insert-redir
done

# One keystroke to cd ..
# bindkey -s '\eu' '\eq^Ucd ..; ls^M'

# Let ^W delete to slashes - zsh-users list, 4 Nov 2005
backward-delete-to-slash() {
  local WORDCHARS=${WORDCHARS//\//}
  zle .backward-delete-word
}
zle -N backward-delete-to-slash
bindkey "^W" backward-delete-to-slash
# end statico thievery

# zsh-sticky-prefix
local zle_sticked=""

zle-line-init() {
BUFFER="$zle_sticked$BUFFER"
zle end-of-line
}
zle -N zle-line-init

function zle-set-sticky {
  zle_sticked="$BUFFER"
  zle -M "Sticky: '$zle_sticked'."
}
zle -N zle-set-sticky
bindkey '^S' zle-set-sticky

function accept-line {
  if [[ -z "$BUFFER" ]] && [[ -n "$zle_sticked" ]]; then
    zle_sticked=""
    echo -n "\nRemoved sticky."
  fi
  zle .accept-line
}
zle -N accept-line
# zsh-sticky
