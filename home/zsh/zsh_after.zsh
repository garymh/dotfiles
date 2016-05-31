# stuff oh-my-zsh tries to overwrite...

if (( $+commands[brew] )) ; then
  HAS_BREW=1
  path=(
    $(brew --prefix)/sbin
    $(brew --prefix)/share/npm/bin
    $(brew --cellar)/coreutils
    $path
  )
fi

