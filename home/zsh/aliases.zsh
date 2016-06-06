if [[ $IS_MAC -eq 1 ]]; then
  alias fix_git_hook="cp $HOME_DIR/git_templates/hooks/post-commit .git/hooks/post-commit"

  alias show_hidden="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app"
  alias hide_hidden="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app"

  alias debug_vim="/usr/local/bin/vim -u ~/.vimrc_min"
  alias debug_nvim="nvim -u ~/.vimrc_min"

  alias ezshenv="$EDITOR $HOME_DIR/zshenv"
  alias ealias="$EDITOR $HOME_DIR/zsh/aliases.zsh"
  alias efunction="$EDITOR $HOME_DIR/zsh/functions.zsh"
  alias egems="$EDITOR $DOTFILES/new_machine/gems"
  alias etmux="$EDITOR $DOTFILES/home/tmux.conf $DOTFILES/home/tmux/gary_theme.conf"
  alias evim="$EDITOR $HOME_DIR/vimrc"
  alias egit="$EDITOR $HOME_DIR/gitconfig"
  alias zshrc="$EDITOR $HOME_DIR/zshrc"

  alias check_permissions="sudo /usr/libexec/repair_packages --verify --standard-pkgs / "
  alias fix_permissions="sudo /usr/libexec/repair_packages --repair --standard-pkgs --volume / && sudo chown -R $(whoami) /usr/local"

  alias oo='open .'

  alias postoff="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop"
  alias poston="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
  alias ldap_on="sudo /usr/local/Cellar/openldap/2.4.43/libexec/slapd -d 1"
  alias vmon="VAGRANT_CWD=~/vagrant vagrant up"
  alias vmoff="VAGRANT_CWD=~/vagrant vagrant suspend"

  alias clean_dropbox-safe="find . -name \"*conflicted*\" -exec mv {} ~/Dropbox/Internal/conflicts/ \;"
  alias clean_dropbox="find . -name \"*conflicted*\" -exec rm {} \;"

  alias plistbuddy="/usr/libexec/PlistBuddy"
  alias cask="brew cask"

  # typos
  alias vm="vmon"
  alias eivm="evim"
  alias evimrc="evim"
  alias ezshrc="zshrc"
  alias eenv="ezshenv"
  alias zshenv="ezshenv"
  alias rvm="rbenv"
fi

if [[ $IS_LINUX -eq 1 ]]; then
  alias cf_on="sudo service coldfusion_10 start"
  alias cf_off="sudo service coldfusion_10 stop"
  alias cf_restart="sudo service coldfusion_10 restart"
fi

alias :q="exit"
alias be="bundle exec"
alias console="rails console test -s"
alias gs="git status -sb"
alias killruby='killall -9 ruby'
alias please='sudo $SHELL -c "$(fc -ln -1)"'
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | green '=> Public key copied to pasteboard.'"
alias ref="source ~/.zshrc"
alias ungit="find . -name '.git' -exec rm -rf {} \;"
alias update_tags="ctags -R . $(bundle list --paths)"

alias deploy_prod="prod_deploy"
alias deploy_stage="stage_deploy"
alias stage_deploy="cap staging deploy"
alias prod_deploy="cap production deploy"

# typos
alias gca="gac"
alias gco="gac"
alias vim="e"

# more verbose fileutils
alias rmdir='rmdir -v'
alias chmod='chmod -v'
alias chown='chown -v'

# zsh global aliases for piping
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
alias -g F='| fzf'
