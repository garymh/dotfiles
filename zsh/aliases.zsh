if [[ $IS_MAC -eq 1 ]]; then
  # stupid apple.
  sudo () { ( unset LD_LIBRARY_PATH DYLD_LIBRARY_PATH; exec command sudo $* ) }

  export EDITOR="stty stop '' -ixoff ; vim"
  alias sub="f -e $EDITOR"
  alias zo="open `f $1`"
  alias tomon='sudo ~/Library/Tomcat/libexec/bin/startup.sh'
  alias tomoff='sudo ~/Library/Tomcat/libexec/bin/shutdown.sh'
  alias poston='pg_ctl -D /usr/local/var/postgres9.3 -l /usr/local/var/postgres9.3/server.log start'
  alias postoff='pg_ctl -D /usr/local/var/postgres9.3 -l /usr/local/var/postgres9.3/server.log stop'
  alias cfon='/Applications/ColdFusion10/cfusion/bin/coldfusion start'
  alias cfoff='/Applications/ColdFusion10/cfusion/bin/coldfusion stop'
  alias cfrestart='/Applications/ColdFusion10/cfusion/bin/coldfusion restart'
  alias fix_keystore='sudo keytool -import -keystore /System/Library/Frameworks/JavaVM.framework/Home/lib/security/cacerts -file /etc/apache2/ssl/server.crt -alias apache_garymbp'
  alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv $HOME/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
  alias clean_dropbox-safe="find . -name \"*conflicted*\" -exec mv {} ~/Dropbox/Internal/DropboxConflicts \;"

  alias clean_dropbox="find . -name \"*conflicted*\" -exec rm {} \;"
  alias tmlog="syslog -F '\$Time \$Message' -k Sender com.apple.backupd-auto -k Time ge -30m | tail -n 1"
  alias timemachine_log="syslog -F '\$Time \$Message' -k Sender com.apple.backupd-auto -k Time ge -30m | tail -n 1"
  alias tp='touch todo.taskpaper && open -a "Taskpaper" todo.taskpaper'
  alias vmon='vm'

  alias keyremap=/Applications/KeyRemap4MacBook.app/Contents/Applications/KeyRemap4MacBook_cli.app/Contents/MacOS/KeyRemap4MacBook_cli
  alias rpx="keyremap reloadxml"
  alias epx="mate ~/Dropbox/Internal/dotfiles/keyremap4macbook.xml"


  alias plistbuddy="/usr/libexec/PlistBuddy"
  #copy output of last command to clipboard
  alias cl="fc -e -|pbcopy"

  alias ql='qlmanage -p 2>/dev/null' # OS X Quick Look
  alias oo='open .' # open current directory in OS X Finder
  # Hall of the Mountain King
  alias cello='say -v cellos "di di di di di di di di di di di di di di di di di di di di di di di di di di"'
  # alias to show all Mac App store apps
  alias apps='mdfind "kMDItemAppStoreHasReceipt=1"'
  # reset Address Book permissions in Mountain Lion (and later presumably)
  alias resetaddressbook='tccutil reset AddressBook'
  # refresh brew by upgrading all outdated casks
  alias refreshbrew='brew outdated | while read cask; do brew upgrade $cask; done'
  # rebuild Launch Services to remove duplicate entries on Open With menu
  alias rebuildopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'
  alias defhist='history 1 | grep "defaults"'

fi

if [[ $IS_LINUX -eq 1 ]]; then
  alias cfon='sudo service coldfusion_10 start'
  alias cfoff='sudo service coldfusion_10 stop'
  alias cfrestart='sudo service coldfusion_10 restart'
fi

alias vi='vim'
alias vim="stty stop '' -ixoff ; vim"
alias subdir='$EDITOR .'
alias mate='$EDITOR' #old habits die hard

alias gs="git status -sb"
alias my_issues='issues'
alias na='ghi list --state open --mine -L high --milestone 4'
alias issues="ghi list --state open --mine"

alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias be="bundle exec"
alias ccat="src-hilite-lesspipe.sh $1"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias whatsmyip="dig +short myip.opendns.com @resolver1.opendns.com"
alias external_ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"
alias killruby='killall -9 ruby'
alias killrudy='killall -9 ruby' #ruby's brother rudy
alias ref="source ~/.zshrc"
alias retag='ctags -R --exclude=.svn --exclude=.git --exclude=log --exclude=tmp *'

alias whois="whois -h whois-servers.net"
alias ungit="find . -name '.git' -exec rm -rf {} \;"

alias last_commit="git difftool HEAD~1 HEAD"
alias last_diff="git difftool HEAD~1 HEAD"
alias console="rails console test -s"

# top
alias ttop='top -ocpu -R -F -s 2 -n30'
alias cpu='top -o cpu'
alias mem='top -o rsize' # memory

# copy the working directory path
alias cpwd='pwd|tr -d "\n"|pbcopy'

# ls better
alias lh='ls -a | egrep "^\."'
alias la="ls -aF"
alias ld="ls -ld"
alias lt='ls -At1 && echo "------Oldest--"'
alias ltr='ls -Art1 && echo "------Newest--"'

# interactive fasd
alias zi="fasd -e cd -i"
# alias zshconfig="$EDITOR $HOME/.zsh/"
alias zshconfig="$EDITOR ~/Dropbox/Internal/dotfiles/zsh"
alias zshtheme="$EDITOR $HOME/Dropbox/Internal/dotfiles/gary.zsh-theme"
alias ohmyzsh="$EDITOR $HOME/.oh-my-zsh"

alias gca="gac"
alias gco="gac"

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

alias dev_on='poston && tomon'
alias dev_off='tomoff && postoff'
alias devon='dev_on'
alias devoff='dev_off'
