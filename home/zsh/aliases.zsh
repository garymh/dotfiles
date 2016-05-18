
if [[ $IS_MAC -eq 1 ]]; then
  alias vim="e"
  alias please='sudo $SHELL -c "$(fc -ln -1)"'

  alias fix_git_hook="cp $HOME_DIR/git_templates/hooks/post-commit .git/hooks/post-commit"
  alias show_hidden='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
  alias hide_hidden='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

  alias debug_vim='/usr/local/bin/vim -u ~/.vimrc_min'
  alias debug_nvim='nvim -u ~/.vimrc_min'

  alias ldap_on="sudo /usr/local/Cellar/openldap/2.4.43/libexec/slapd -d 1"

  alias eshortcuts="$EDITOR ~/Library/Mobile\ Documents/com~apple~CloudDocs/shortcuts"
  alias eshortcut="eshortcuts"

  alias ealias="$EDITOR $HOME_DIR/zsh/aliases.zsh"
  alias efunction="$EDITOR $HOME_DIR/zsh/functions.zsh"
  alias egems="$EDITOR $DOTFILES/new_machine/gems"
  alias etmux="$EDITOR $DOTFILES/home/tmux.conf $DOTFILES/home/tmux/gary_theme.conf"

  alias evim="$EDITOR $HOME_DIR/vimrc"
  alias eivm="evim"
  alias evimrc="evim"
  alias zshrc="$EDITOR $HOME_DIR/zshrc"
  alias ezshrc="zshrc"

  alias oo='open .'

  alias postoff='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop'
  alias poston='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'

  alias update_tags="ctags -R . $(bundle list --paths)"

  alias fix_keystore='sudo keytool -import -keystore /System/Library/Frameworks/JavaVM.framework/Home/lib/security/cacerts -file /etc/apache2/ssl/server.crt -alias apache_garymbp'
  alias clean_dropbox-safe="find . -name \"*conflicted*\" -exec mv {} ~/Dropbox/Internal/DropboxConflicts \;"
  alias clean_dropbox="find . -name \"*conflicted*\" -exec rm {} \;"

  alias vmon='vm'
  alias plistbuddy="/usr/libexec/PlistBuddy"
fi

if [[ $IS_LINUX -eq 1 ]]; then
  alias cf_on='sudo service coldfusion_10 start'
  alias cf_off='sudo service coldfusion_10 stop'
  alias cf_restart='sudo service coldfusion_10 restart'

  if [ "$HOSTNAME" = "nightcrawler" ]; then
    alias vim="nvim"
    alias tmux="TERM=screen-256color-bce tmux"
  fi
fi

alias stage_deploy="cap staging deploy"
alias prod_deploy="cap production deploy"
alias stage_deploy="csd"
alias prod_deploy="cpd"

alias gs="git status -sb"
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | green '=> Public key copied to pasteboard.'"
alias be="bundle exec"
alias killruby='killall -9 ruby'
alias ref="source ~/.zshrc"
alias ungit="find . -name '.git' -exec rm -rf {} \;"
alias rvm="rbenv"

alias console="rails console test -s"
alias :q="exit"

# top
alias ttop='top -ocpu -R -F -s 2 -n30'
alias cpu='top -o cpu'
alias mem='top -o rsize' # memory

# ls better
alias la="ls -aF"
alias lh='ls -d .*'
alias ll='ls -lh'

# interactive fasd
alias zi="fasd -e cd -i"

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
alias -g NUL="> /dev/null 2>&1"
alias -g S='| sort'
alias -g T='| tail'
