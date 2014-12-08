if [[ $IS_MAC -eq 1 ]]; then
  # stupid apple.
  sudo () { ( unset LD_LIBRARY_PATH DYLD_LIBRARY_PATH; exec command sudo $* ) }

  alias tmux="TERM=screen-256color-bce tmux"

  alias oo='open .'
  alias update_tags="ctags -R . $(bundle list --paths)"

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

# alias vim="stty stop '' -ixoff ; vim"
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
# alias la="ls -aF"
alias lh='ls -a | egrep "^\."'
# alias lt='ls -At1 && echo "------Oldest--"'
# alias ltr='ls -Art1 && echo "------Newest--"'

# alias ld="ls -ld"
# alias lh='ls -l .??*'

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
alias -g .....='../../../..'
alias -g ....='../../..'
alias -g ...='../..'
alias -g C='| tr -d "\n" | pbcopy'
alias -g CA="2>&1 | cat -A"
alias -g D='~/Desktop/'
alias -g G='| grep'
alias -g H='| head'
alias -g L="| less"
alias -g LL="2>&1 | less"
alias -g M="| most"
alias -g N='~/code/nudais/rails/'
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g S='| sort'
alias -g T='| tail'

alias tom_on="tomon"
alias tom_off="tomoff"
alias post_on="poston"
alias post_off="postoff"
alias cf_on="cfon"
alias cf_off="cfoff"
alias cf_restart="cfrestart"

if [ ${ZSH_VERSION//\./} -ge 420 ]; then
  # open browser on urls
  _browser_fts=(htm html de org net com at cx nl se dk dk php)
  for ft in $_browser_fts ; do alias -s $ft=$BROWSER ; done

  _editor_fts=(cpp cxx cc c hh h inl asc txt TXT tex)
  for ft in $_editor_fts ; do alias -s $ft=$EDITOR ; done

  _image_fts=(jpg jpeg png gif mng tiff tif xpm)
  for ft in $_image_fts ; do alias -s $ft=$XIVIEWER; done

  _media_fts=(ape avi flv mkv mov mp3 mpeg mpg ogg ogm rm wav webm)
  for ft in $_media_fts ; do alias -s $ft=mplayer ; done

  #read documents
  alias -s pdf=acroread
  alias -s ps=gv
  alias -s dvi=xdvi
  alias -s chm=xchm
  alias -s djvu=djview

  #list whats inside packed file
  alias -s zip="unzip -l"
  alias -s rar="unrar l"
  alias -s tar="tar tf"
  alias -s tar.gz="echo "
  alias -s ace="unace l"
fi

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
