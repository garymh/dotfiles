unsetopt correct_all
unsetopt correct # so annoying
unsetopt promptcr

setopt prompt_subst # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt transient_rprompt # only show the rprompt on the current prompt

path=(
  ${HOME}/bin
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
        $path
        $(brew --prefix)/bin
        $(brew --prefix)/sbin
        $(brew --prefix)/share/npm/bin
        $(brew --cellar)/coreutils
        )
fi

if [[ $IS_LINUX -eq 1 ]]; then
  path=(
        $path
        /.rvm/bin
        )
fi


if [ $(command -v fasd) ]; then
  fasd_cache="$HOME/.fasd-init-zsh"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
  fi
  source "$fasd_cache"
  unset fasd_cache
fi

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

  export JAVA_OPTS="-Djava.awt.headless=true"

  # GRC colorizes nifty unix tools all over the place
  if $(grc &>/dev/null)
  then
    source `brew --prefix`/etc/grc.bashrc
  fi
fi

if [[ $IS_LINUX -eq 1 ]]; then
  export LD_LIBRARY_PATH="LD_LIBRARY_PATH=/usr/lib/oracle/11.2/client64//lib:/lib:/usr/lib64:/usr/lib:/usr/local/lib"
  export ORACLE_HOME="/usr/lib/oracle/11.1/client64"
  export PATH="/opt/ruby-enterprise/bin:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:$PATH"
  export NLS_LANG=AMERICAN_AMERICA.WE8MSWIN1252
fi

export VISUAL='$EDITOR'
export LESS='--ignore-case --RAW-CONTROL-CHARS --LONG-PROMPT'
export PAGER=less
export TERM=xterm-256color
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
