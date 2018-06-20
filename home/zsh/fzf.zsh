if [[ -f ~/.fzf.zsh ]]; then
  if which rg >/dev/null 2>&1; then
    # export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
    export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
    [ -n "$NVIM_LISTEN_ADDRESS" ] && export FZF_DEFAULT_OPTS='--no-height'
  else
    export FZF_DEFAULT_COMMAND='ag -l -g ""'
  fi

  fzf-down() {
    fzf --height 50% "$@" --border
  }

  # fco - checkout git branch/tag
  branch() {
    local tags branches target
    tags=$(git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
    branches=$(
    git branch --all | grep -v HEAD             |
      sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
      sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
    target=$(
    (echo "$tags"; echo "$branches") | sed '/^$/d' |
      fzf-down --no-hscroll --reverse --ansi +m -d "\t" -n 2 -q "$*") || return
    git checkout $(echo "$target" | awk '{print $2}')
  }

  bash_into_docker() { docker exec -it $(docker ps --format "{{.Names}}" | fzf | cat) /bin/bash }

  # super cool trick from https://adamheins.com/blog/ctrl-p-in-the-terminal-with-fzf
  # This is the same functionality as fzf's ctrl-t, except that the file or
  # directory selected is now automatically cd'ed or opened, respectively.
  fzf-open-file-or-dir() {
  local cmd="command find -L . \
    \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | sed 1d | cut -b3-"
  local out=$(eval $cmd | fzf-tmux --exit-0)

  if [ -f "$out" ]; then
    $EDITOR "$out" < /dev/tty
  elif [ -d "$out" ]; then
    cd "$out"
    zle reset-prompt
  fi
  }
  zle     -N   fzf-open-file-or-dir
  bindkey '^P' fzf-open-file-or-dir

  if [ -x ~/.vim/plugged/fzf.vim/bin/preview.rb ]; then
    export FZF_CTRL_T_OPTS="--preview '~/.vim/plugged/fzf.vim/bin/preview.rb {} | head -200'"
  fi

  export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"

  command -v blsd > /dev/null && export FZF_ALT_C_COMMAND='blsd $dir'
  command -v tree > /dev/null && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

  source ~/.fzf.zsh
fi
