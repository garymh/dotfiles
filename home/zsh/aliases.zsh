if [[ $IS_MAC -eq 1 ]]; then
  # stupid apple.
  sudo () { ( unset LD_LIBRARY_PATH DYLD_LIBRARY_PATH; exec command sudo $* ) }

  alias tmux="TERM=screen-256color-bce tmux"
  alias ls=' gls -C -F -h --color=always'

  alias tomon='sudo ~/Library/Tomcat/libexec/bin/startup.sh'
  alias tomoff='sudo ~/Library/Tomcat/libexec/bin/shutdown.sh'
  alias poston='pg_ctl -D /usr/local/var/postgres9.3 -l /usr/local/var/postgres9.3/server.log start'
  alias postoff='pg_ctl -D /usr/local/var/postgres9.3 -l /usr/local/var/postgres9.3/server.log stop'
  alias cfon='/Applications/ColdFusion10/cfusion/bin/coldfusion start'
  alias cfoff='/Applications/ColdFusion10/cfusion/bin/coldfusion stop'
  alias cfrestart='/Applications/ColdFusion10/cfusion/bin/coldfusion restart'

  alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'
  alias fix_keystore='sudo keytool -import -keystore /System/Library/Frameworks/JavaVM.framework/Home/lib/security/cacerts -file /etc/apache2/ssl/server.crt -alias apache_garymbp'
  alias clean_dropbox-safe="find . -name \"*conflicted*\" -exec mv {} ~/Dropbox/Internal/DropboxConflicts \;"
  alias clean_dropbox="find . -name \"*conflicted*\" -exec rm {} \;"
  alias vmon='vm'
  alias plistbuddy="/usr/libexec/PlistBuddy"
  alias app_store_apps='mdfind "kMDItemAppStoreHasReceipt=1"'
fi

if [[ $IS_LINUX -eq 1 ]]; then
  alias cfon='sudo service coldfusion_10 start'
  alias cfoff='sudo service coldfusion_10 stop'
  alias cfrestart='sudo service coldfusion_10 restart'
fi

alias vim="stty stop '' -ixoff ; vim"
alias gs="git status -sb"
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias be="bundle exec"
alias ccat="src-hilite-lesspipe.sh $1"
alias killruby='killall -9 ruby'
alias ref="source ~/.zshrc"

alias ungit="find . -name '.git' -exec rm -rf {} \;"

alias last_commit="git difftool HEAD~1 HEAD"
alias last_diff="git difftool HEAD~1 HEAD"
alias console="rails console test -s"

# top
alias ttop='top -ocpu -R -F -s 2 -n30'
alias cpu='top -o cpu'
alias mem='top -o rsize' # memory

# ls better
alias lh='ls -a | egrep "^\."'
alias la="ls -aF"
alias ld="ls -ld"
alias lt='ls -At1 && echo "------Oldest--"'
alias ltr='ls -Art1 && echo "------Newest--"'

alias ..='cd ..'

# interactive fasd
alias zi="fasd -e cd -i"

alias gca="gac"
alias gco="gac"

alias -g RES='RAILS_ENV=staging'

# More verbose fileutils
alias cp='nocorrect cp -iv'
alias rm='nocorrect rm -iv'
alias mv='nocorrect mv -iv'
alias rmdir='rmdir -v'
alias chmod='chmod -v'
alias chown='chown -v'

# ZSH global aliases for piping
alias -g G='| grep -in'
alias -g T='| tail'
alias -g L='| less'
alias -g C='| tr -d "\n" | pbcopy'
alias -g N='~/code/nudais/rails/'
alias -g D='~/Desktop/'

alias tom_on="tomon"
alias tom_off="tomoff"
alias post_on="poston"
alias post_off="postoff"
alias cf_on="cfon"
alias cf_off="cfoff"
alias cf_restart="cfrestart"

alias whereami='echo "$HOST, silly"'
