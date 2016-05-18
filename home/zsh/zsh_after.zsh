# stuff oh-my-zsh tries to overwrite...

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export PAGER='less'
export LESS='--ignore-case --RAW-CONTROL-CHARS --LONG-PROMPT'
export LESSOPEN="| src-hilite-lesspipe.sh %s"

unalias v
unalias o

# something is screwing up my path in oh-my-zsh
if (( $+commands[brew] )) ; then
  HAS_BREW=1
  path=(
    $(brew --prefix)/sbin
    $(brew --prefix)/share/npm/bin
    $(brew --cellar)/coreutils
    $path
  )
fi

