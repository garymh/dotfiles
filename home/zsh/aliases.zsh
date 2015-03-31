
if [[ $IS_MAC -eq 1 ]]; then
  alias vim="nvim"
  alias fix_git_hook="cp ~/Dropbox/Internal/dotfiles/home/git_templates/hooks/post-commit .git/hooks/post-commit"

  alias oo='open .'
  alias update_tags="ctags -R . $(bundle list --paths)"
  alias ccat="src-hilite-lesspipe.sh $1"
  alias tomon='sudo ~/Library/Tomcat/libexec/bin/startup.sh'
  alias tomoff='sudo ~/Library/Tomcat/libexec/bin/shutdown.sh'
  alias poston='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
  alias postoff='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop'
  alias cfon='/Applications/ColdFusion10/cfusion/bin/coldfusion start'
  alias cfoff='/Applications/ColdFusion10/cfusion/bin/coldfusion stop'
  alias cfrestart='/Applications/ColdFusion10/cfusion/bin/coldfusion restart'
  alias screensaver='/System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine &'
  alias zshrc="vim ~/Dropbox/Internal/dotfiles/home/zshrc"
  alias evim="vim ~/Dropbox/Internal/dotfiles/home/vimrc"
  alias eivm="evim"
  alias evimrc="evim"

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

alias gs="git status -sb"
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | green '=> Public key copied to pasteboard.'"
alias be="bundle exec"
alias killruby='killall -9 ruby'
alias ref="source ~/.zshrc"
alias ungit="find . -name '.git' -exec rm -rf {} \;"

alias last_commit="git difftool HEAD~1 HEAD"
alias last_diff="git difftool HEAD~1 HEAD"
alias console="rails console test -s"
alias :q="exit"

# top
alias ttop='top -ocpu -R -F -s 2 -n30'
alias cpu='top -o cpu'
alias mem='top -o rsize' # memory

# ls better
alias la="ls -aF"
alias lh='ls -d .*'
# alias lh='gls --color=always -a | egrep "^\."'
alias ll='gls --color=always -lh'

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
