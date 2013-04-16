# == TEXT
export EDITOR="$HOME/bin/editor.sh"
export ACTUAL_EDITOR="$HOME/bin/subl"
alias vi='vim'
alias subdir='$EDITOR .'
alias mate='$EDITOR' #old habits die hard
alias sub="f -e $EDITOR"

# == mac only
if [[ "$(uname)" == 'Darwin' ]]; then
  alias tomon='sudo ~/Library/Tomcat/libexec/bin/startup.sh'
  alias tomoff='sudo ~/Library/Tomcat/libexec/bin/shutdown.sh'
  alias poston='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
  alias postoff='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop'
  alias cfon='/Applications/ColdFusion10/cfusion/bin/coldfusion start'
  alias cfoff='/Applications/ColdFusion10/cfusion/bin/coldfusion stop'
  alias cfrestart='/Applications/ColdFusion10/cfusion/bin/coldfusion restart'
  alias fix_keystore='sudo keytool -import -keystore /System/Library/Frameworks/JavaVM.framework/Home/lib/security/cacerts -file /etc/apache2/ssl/server.crt -alias apache_garymbp'
  alias dev_on='poston && cfon && tomon && vmon'
  alias dev_off='postoff && cfoff && tomoff && vmoff'
  alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv $HOME/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
  alias clean_dropbox-safe="find . -name \"*conflicted*\" -exec mv {} ~/Dropbox/Internal/DropboxConflicts \;"
  alias clean_dropbox="find . -name \"*conflicted*\" -exec rm {} \;"
  alias tmlog="syslog -F '\$Time \$Message' -k Sender com.apple.backupd-auto -k Time ge -30m | tail -n 1"
  alias timemachine_log="syslog -F '\$Time \$Message' -k Sender com.apple.backupd-auto -k Time ge -30m | tail -n 1"
  alias tp='touch todo.taskpaper && open -a "Taskpaper" todo.taskpaper'
fi


# alias be="bundle exec"
alias ccat="src-hilite-lesspipe.sh $1"
alias gurad='guard'
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias whatsmyip="dig +short myip.opendns.com @resolver1.opendns.com"
alias external_ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"
alias killruby='killall -9 ruby'
alias killrudy='killall -9 ruby' #ruby's brother rudy
alias ref="source ~/.zshrc"
alias retag='ctags -R --exclude=.svn --exclude=.git --exclude=log --exclude=tmp *'
alias rvm-prompt=$HOME/.rvm/bin/rvm-prompt
alias vmon='vm'     #i'm an idiot and need 2 alises for each command
alias whois="whois -h whois-servers.net"
alias ungit="find . -name '.git' -exec rm -rf {} \;"
alias console="cd `d rails` && bundle exec rails console"

#copy output of last command to clipboard
alias cl="fc -e -|pbcopy"

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
alias ll="ls -l"
alias lt='ls -At1 && echo "------Oldest--"'
alias ltr='ls -Art1 && echo "------Newest--"'

# interactive fasd
alias zi="fasd -e cd -i"

alias zshconfig="$EDITOR $HOME/.zsh/"
alias zshtheme="$EDITOR $HOME/Dropbox/Internal/dotfiles/gary.zsh-theme"
alias ohmyzsh="$EDITOR $HOME/.oh-my-zsh"
alias edit_theme="$EDITOR $ZSH_CUSTOM/gary.zsh-theme"

alias gca="gac"
alias gco="gac" # i'm dumb.

# More verbose fileutils
alias cp='nocorrect cp -iv'
alias rm='nocorrect rm -iv'
alias mv='nocorrect mv -iv'
alias rmdir='rmdir -v'
alias chmod='chmod -v'
alias chown='chown -v'

# ZSH global aliases for piping
# Example : cat myfile.txt G pattern
alias -g G='| grep -in'
alias -g T='| tail'
alias -g L='| less'

alias tom_on="tom_on"
alias tom_off="tom_off"
alias post_on="post_on"
alias post_off="post_off"
alias cf_on="cf_on"
alias cf_off="cf_off"
alias cf_restart="cf_restart"