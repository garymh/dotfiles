unsetopt correct_all
unsetopt correct # so annoying

unsetopt promptcr

path=(
  ${HOME}/bin
  $(brew --prefix)/bin
  $(brew --prefix)/sbin
  $(brew --prefix)/share/npm/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
  /usr/X11/bin
  $(brew --cellar)/coreutils
)

if [ $(command -v fasd) ]; then
  fasd_cache="$HOME/.fasd-init-zsh"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
  fi
  source "$fasd_cache"
  unset fasd_cache
fi

if [[ "$(uname)" == 'Darwin' ]]; then
  #Oracle >:(

  export DYLD_LIBRARY_PATH="$ORACLE_HOME"
  export TNS_ADMIN="/usr/local/oracle/network/admin/"
  export SQLPATH="/usr/local/oracle/instantclient_11_2"
  export ORACLE_HOME="/usr/local/oracle/instantclient_11_2"
  export NLS_LANG=AMERICAN_AMERICA.WE8MSWIN1252
  export PATH="$PATH:$DYLD_LIBRARY_PATH"
  export LIBDIR="/usr/local/lib"
  export RC_ARCHS=x86_64

  # GRC colorizes nifty unix tools all over the place
  if $(grc &>/dev/null)
  then
    source `brew --prefix`/etc/grc.bashrc
  fi
fi

export VISUAL='$EDITOR'
export LESS='--ignore-case --RAW-CONTROL-CHARS --LONG-PROMPT'
export PAGER=less
export TERM=xterm-256color
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
