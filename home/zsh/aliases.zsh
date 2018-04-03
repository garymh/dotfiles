if [[ $IS_MAC -eq 1 ]]; then
  alias fix_git_hook="cp $HOME_DIR/git_templates/hooks/post-commit .git/hooks/post-commit"

  alias show_hidden="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app"
  alias hide_hidden="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app"

  alias debug_vim="/usr/local/bin/vim -u ~/.vimrc_min"
  alias debug_nvim="nvim -u ~/.vimrc_min"

  alias debug_vimrc="/usr/local/bin/vim -u ~/.vimrc_min ~/.vimrc_min"
  alias debug_nvimrc="nvim -u ~/.vimrc_min ~/.vimrc_min"

  alias vvim="/usr/local/bin/vim"

  alias gd='git diff --color | sed -E "s/^([^-+ ]*)[-+ ]/\\1/" | less -r'

  alias netwtf='sudo /usr/local/sbin/mtr -n 8.8.8.8'

  alias ezshenv="$EDITOR $HOME_DIR/zshenv"
  alias ekar="$EDITOR $HOME_DIR/karabiner.json"
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
  alias plistbuddy="/usr/libexec/PlistBuddy"
  alias cask="brew cask"
  alias dc="docker-compose run web"

  alias restore_db="pg_restore -h localhost -p 5432 -U postgres -d membership_user -O -c -v"

  # typos
  alias eivm="evim"
  alias evimrc="evim"
  alias ezshrc="zshrc"
  alias eenv="ezshenv"
  alias zshenv="ezshenv"
fi

if [[ $IS_LINUX -eq 1 ]]; then
  alias cf_on="sudo service coldfusion_10 start"
  alias cf_off="sudo service coldfusion_10 stop"
  alias cf_restart="sudo service coldfusion_10 restart"
  alias prod="RAILS_ENV=production bundle exec"
  alias stage="RAILS_ENV=staging bundle exec"

  alias db_dump="pg_dump $DATABASE_URL -F c -b --no-acl -v -f ~/db_dump"
fi


alias devlog='tail -f log/development.log'
alias prodlog='tail -f log/production.log'
alias testlog='tail -f log/test.log'

alias -g RED='RAILS_ENV=development'
alias -g REP='RAILS_ENV=production'
alias -g RET='RAILS_ENV=test'
alias -g RES='RAILS_ENV=staging'

alias :q="exit"
alias be="bundle exec"
alias console="rails console test -s"
alias gs="git status -sb"
alias killruby='killall -9 ruby'
alias please='sudo $SHELL -c "$(fc -ln -1)"'
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | green '=> Public key copied to pasteboard.'"
alias ref="src"
alias ungit="find . -name '.git' -exec rm -rf {} \;"
# alias update_tags="ctags -R . $(bundle list --paths)"

alias deploy_prod="prod_deploy"
alias deploy_stage="stage_deploy"
alias stage_deploy="cap staging deploy"
alias prod_deploy="cap production deploy"

alias spaces2underscores='for i in *; do mv -iv "$i" "${i// /_}"; done'
alias dcup='rm tmp/pids/server.pid ; docker-compose up'
# alias dcup='rm tmp/pids/server.pid ; docker-sync-stack start'

e_header()  { echo -e "\n\033[1m$@\033[0m"; }
e_success() { echo -e " \033[1;32m✔\033[0m  $@"; }
e_error()   { echo -e " \033[1;31m✖\033[0m  $@"; }

alias z="j"
alias ..="cd .."

# typos
alias gca="gac"
alias gco="gac"
alias vim="e"

# more verbose fileutils
alias rmdir='rmdir -v'
alias chmod='chmod -v'
alias chown='chown -v'

# git alises
alias co='git checkout'
alias new_branch="git checkout -b"
alias branches='git branches'

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
