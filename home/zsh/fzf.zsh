if [[ -f ~/.fzf.zsh ]]; then
  export FZF_DEFAULT_COMMAND='fd --type f --color=always --hidden -L'
  export FZF_DEFAULT_OPTS="--ansi
                           --info=inline
                           --multi --reverse
                           --header '? - toggle preview, <C-f/b> pages, <C-o> opens, <C-y> copies, <C-a> all+confirm'
                           --preview-window='right:50%:hidden'
                           --bind '?:toggle-preview'
                           --bind 'ctrl-a:select-all+accept'
                           --bind 'ctrl-o:execute[open {}]'
                           --bind 'ctrl-f:page-down'
                           --bind 'tab:toggle+up'
                           --bind 'ctrl-b:page-up'
                           --bind 'ctrl-y:execute[echo {} | pbcopy]'
                           --prompt='❯ '
                           --pointer='❯'
                           --marker='✔'"

              # fzf exports $FZF_PREVIEW_LINES and $FZF_PREVIEW_COLUMNS so that they represent the exact size of the preview  window.  (It  also  overrides
              # $LINES  and $COLUMNS with the same values but they can be reset by the default shell, so prefer to refer to the ones with FZF_PREVIEW_ pre-
              # fix.)

  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --preview '~/.vim/plugged/fzf.vim/bin/preview.sh {} | head -200' --select-1 --exit-0"
  export FZF_ALT_C_COMMAND='fd --type d . --color=always --hidden'
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

  # Use ~~ as the trigger sequence instead of the default **
  export FZF_COMPLETION_TRIGGER='~~'

  # Options to fzf command
  export FZF_COMPLETION_OPTS='+c -x'

  rake_fzf() {
    local inst=$(rake -T | fzf -m --preview '' | cut -d ' ' -f 2 | perl -pe 'if(!eof){s/\n/ /}')

    if [[ $inst ]]; then
      rake $inst
    fi
  }

  _fzf_compgen_path() {
    fd --hidden . "$1"
  }

  _fzf_compgen_dir() {
    fd --type d --hidden . "$1"
  }

  brewfzf() {
    local inst=$(brew search | eval "fzf --inline-info -m --no-preview --header='[brew:$1]'")

    if [[ $inst ]]; then
      for prog in $(echo $inst)
      do brew $1 $prog
      done
    fi
  }

  bip() { brewfzf install }
  bhome() { brewfzf home }

  # find path
  fp() {
    local loc=$(echo $PATH | sed -e $'s/:/\\\n/g' | eval "fzf --header='[find:path]'")

    if [[ -d $loc ]]; then
      echo "$(rg --files $loc | rev | cut -d"/" -f1 | rev)" | eval "fzf --header='[find:exe] => ${loc}' >/dev/null"
      fp
    fi
  }

  fzf-dotf() {
    local working_dir=$(pwd)
    cd $DOTFILES
    local out=$(eval $FZF_CTRL_T_COMMAND | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf -m "$@")

    if [ -f "$out" ]; then
      $VISUAL "$out" < /dev/tty
    elif [ -d "$out" ]; then
      open "$out"
      zle reset-prompt
    fi
    cd $working_dir
  }

  fzf-nvim() {
  local out=$(eval $FZF_CTRL_T_COMMAND | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf -m "$@")

    if [ -f "$out" ]; then
      $VISUAL "$out" < /dev/tty
    elif [ -d "$out" ]; then
      open "$out"
      zle reset-prompt
    fi
  }

  bindkey '^g^g' fzf-git-checkout-branch
  bindkey '^g^d' fzf-git-delete-branches

  zle     -N   fzf-dotf
  bindkey '^F' fzf-dotf

  zle     -N   fzf-nvim
  bindkey '^P' fzf-nvim

  source ~/.fzf.zsh
fi
