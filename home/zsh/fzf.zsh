if [[ -f ~/.fzf.zsh ]]; then
  export FZF_DEFAULT_COMMAND='fd --type file --color=always --hidden'
  export FZF_DEFAULT_COMMAND_COLORLESS='fd --type file --hidden'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS="--ansi
                          --preview '~/.vim/plugged/fzf.vim/bin/preview.rb {} | head -200'
                          --bind ctrl-f:page-down,ctrl-b:page-up,'ctrl-o:execute($VISUAL {})+abort'"
  export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --select-1 --exit-0"
  export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:wrap 
                          --bind '?:toggle-preview' 
                          --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' 
                          --header 'Press CTRL-Y to copy command into clipboard' --border"
  export FZF_ALT_C_COMMAND='fd --type d . --color=never'
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

  # Use ~~ as the trigger sequence instead of the default **
  # export FZF_COMPLETION_TRIGGER='~~'

  # Options to fzf command
  # export FZF_COMPLETION_OPTS='+c -x'

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

  bash_into_docker() {
    docker exec -it $(docker ps --format "{{.Names}}" | fzf --no-preview | cat) /bin/bash
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
    local out=$(eval fd --color=always --hidden . | fzf)

    if [ -f "$out" ]; then
      $VISUAL "$out" < /dev/tty
    elif [ -d "$out" ]; then
      open "$out"
      zle reset-prompt
    fi
    cd $working_dir
  }

  zle     -N   fzf-dotf
  bindkey '^F' fzf-dotf

  fzf-ctrlp() {
    local out=$(eval $FZF_DEFAULT_COMMAND | fzf)

    if [ -f "$out" ]; then
      $VISUAL "$out" < /dev/tty
    elif [ -d "$out" ]; then
      cd "$out"
      zle reset-prompt
    fi
  }

  zle     -N   fzf-ctrlp
  bindkey '^P' fzf-ctrlp

  source ~/.fzf.zsh
fi
