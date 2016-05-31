# Custom fuzzy completion for "doge" command
#   e.g. doge **<TAB>
_fzf_complete_doge() {
  _fzf_complete "" "$@" < <(
    git branch -vv
  )
}

_fzf_complete_doge_post() {
  awk '{print $1}'
}

_fzf_complete_git() {
  ARGS="$@"
  if [[ $ARGS == 'git checkout'* ]]; then
    _fzf_complete "--no-sort" "$@" < <(
      { git branches & git tags }
    )
  else
    eval "zle ${fzf_default_completion:-expand-or-complete}"
  fi
}

_fzf_complete_git_post() {
  # cut -f2 -d' '
  awk '{print $1}' | sed "s/.* //"
}
