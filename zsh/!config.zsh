unsetopt correct_all
unsetopt correct # so annoying
unsetopt promptcr

setopt transient_rprompt # only show the rprompt on the current prompt

path=(
  ${HOME}/bin
  ${HOME}/.zsh/bin
  /usr/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
  /usr/X11/bin
  /usr/local/heroku/bin
)

if [[ $HAS_BREW -eq 1 ]]; then
  path=(
        $(brew --prefix)/bin
        $(brew --prefix)/sbin
        $(brew --prefix)/share/npm/bin
        $(brew --cellar)/coreutils
        $path
        )
fi

if [[ $IS_LINUX -eq 1 ]]; then
  export LD_LIBRARY_PATH="/usr/lib/oracle/11.2/client64//lib:/lib:/usr/lib64:/usr/lib:/usr/local/lib"
  export PATH="/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/lib/oracle/11.2/client64//bin:/home/gmh219/bin"
  export ORACLE_HOME="/usr/lib/oracle/11.2/client64/"
  export export="/usr/bin/ruby:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/lib/oracle/11.2/client64//bin"
  export USER="gmh219"

  export EDITOR="$HOME/bin/rmate"
fi

if [ $(command -v fasd) ]; then
  fasd_cache="$HOME/.fasd-init-zsh"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
  fi
  source "$fasd_cache"
  unset fasd_cache
fi

export VISUAL='$EDITOR'
export LESS='--ignore-case --RAW-CONTROL-CHARS --LONG-PROMPT'
export TERM=xterm-256color
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

if [[ $IS_MAC -eq 1 ]]; then
  #Oracle >:(
  export TNS_ADMIN="/usr/local/oracle/network/admin/"
  export SQLPATH="/usr/local/oracle/instantclient_11_2"
  export ORACLE_HOME="/usr/local/oracle/instantclient_11_2"
  export ORACLE_SID="xe"
  export DYLD_LIBRARY_PATH="$ORACLE_HOME"
  export NLS_LANG=AMERICAN_AMERICA.WE8MSWIN1252
  export PATH="$PATH:$DYLD_LIBRARY_PATH"

  export LIBDIR="/usr/local/lib"
  export RC_ARCHS=x86_64
  # export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home"
  export JAVA_OPTS="-Djava.awt.headless=true"
  export SSL_CERT_FILE="/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt"
  export DOCKER_HOST=localhost
  export CC=gcc-4.2
  # for my mbpr
  export RUBY_GC_MALLOC_LIMIT=1000000000
  export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1.25
  export RUBY_HEAP_MIN_SLOTS=800000
  export RUBY_FREE_MIN=600000
  export LD_PRELOAD=/usr/lib/libtcmalloc_minimal.so

  # GRC colorizes nifty unix tools all over the place
  if $(grc &>/dev/null)
  then
    source `brew --prefix`/etc/grc.bashrc
  fi
fi
