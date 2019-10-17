if _macos; then
  alias disk_space="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
  alias show_hidden="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app"
  alias hide_hidden="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app"

  alias debug_vim="/usr/local/bin/vim -u ~/.vimrc_min"
  alias debug_nvim="nvim -u ~/.vimrc_min"

  alias debug_vimrc="/usr/local/bin/vim -u ~/.vimrc_min ~/.vimrc_min"
  alias debug_nvimrc="nvim -u ~/.vimrc_min ~/.vimrc_min"

  alias ezshenv="$VISUAL $HOME_DIR/zshenv"
  alias ekar="$VISUAL $HOME_DIR/karabiner.json"
  alias ealias="$VISUAL $HOME_DIR/zsh/aliases.zsh"
  alias efunction="$VISUAL $HOME_DIR/zsh/functions.zsh"
  alias egems="$VISUAL $DOTFILES/new_machine/gems"
  alias eprivate="$VISUAL $DOTFILES/home/zsh/private/private.zsh"
  alias escriptable="$VISUAL $HOME/Library/Mobile\ Documents/iCloud\~dk\~simonbs\~Scriptable/Documents"
  alias etmux="$VISUAL $DOTFILES/home/tmux.conf"
  alias evim="$VISUAL $HOME_DIR/vimrc"
  alias egit="$VISUAL $HOME_DIR/gitconfig"
  alias zshrc="$VISUAL $HOME_DIR/zshrc"
  alias g="git"

  alias netwtf='sudo /usr/local/sbin/mtr -n 8.8.8.8'
  alias oo='open .'
  alias plistbuddy="/usr/libexec/PlistBuddy"
  alias cask="brew cask"
  alias cpu="gotop -c monokai -f"
  alias restore_db="pg_restore -h localhost -p 5432 -U postgres -d membership_user -O -c -v"

  alias renee_notes="$VISUAL ~/Documents/Work/NU/renee-meeting"
  alias work_todos="$VISUAL ~/Documents/Work/NU/work_todos"
  alias dnd_notes="$VISUAL ~/Documents/Fun/D\&D/dndnotes"

  # typos
  alias eivm="evim"
  alias evimrc="evim"
  alias ezshrc="zshrc"
  alias eenv="ezshenv"
  alias zshenv="ezshenv"

  # git things
  alias gcb="git create-branch -r"
  alias gd="git ksdiff"

  # ruby aliases
  alias gin="gem install"
  alias gun="gem uninstall"
  alias gli="gem list"
  alias rdm="rake db:migrate"
  alias rdc="rake db:create"
  alias rdd="rake db:drop"
  alias rr="rake routes"
fi

if _linux; then
  alias cf_on="sudo service coldfusion_10 start"
  alias cf_off="sudo service coldfusion_10 stop"
  alias cf_restart="sudo service coldfusion_10 restart"
  alias prod="RAILS_ENV=production bundle exec"
  alias stage="RAILS_ENV=staging bundle exec"
  alias db_dump="pg_dump $DATABASE_URL -F c -b --no-acl -v -f ~/db_dump"
fi

# alias update_tags="ctags -R . $(bundle list --paths)"
alias ..="cd .."
alias :q="exit"
alias branches='git branches'
alias co='branch'
alias console="rails console test -s"
alias cov="open tmp/coverage/index.html"
alias coverage="rake test && rake test:system && open tmp/coverage/index.html"
alias dcup='rm tmp/pids/server.pid ; docker-compose up'
alias deploy_prod="prod_deploy"
alias deploy_stage="stage_deploy"
alias gco='git checkout'
alias gs="git status -sb"
alias killruby='killall -9 ruby'
alias new_branch="git checkout -b"
alias please='sudo $SHELL -c "$(fc -ln -1)"'
alias prod_deploy="cap production deploy"
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | green '=> Public key copied to pasteboard.'"
alias rails_log="tail -f log/$(echo ${RAILS_ENV:-development} | tr '[:upper:]' '[:lower:]').log"
alias ref="src"
alias spaces2underscores='for i in *; do mv -iv "$i" "${i// /_}"; done'
alias stage_deploy="cap staging deploy"
alias ungit="find . -name '.git' -exec rm -rf {} \;"
alias x+="+x"

if _exists bat; then
  alias cat='bat'
fi

if _exists prettyping; then
  alias ping='prettyping --nolegend'
fi

if _exists trash; then
  alias rm='trash'
else
  alias rm='rm -i'
fi

# typos
alias gca="gac"
alias vim="$VISUAL"

# more verbose fileutils
for c in cp chmod chown rename; do
  alias $c="$c -v"
done

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

alias -g RED='RAILS_ENV=development'
alias -g REP='RAILS_ENV=production'
alias -g RET='RAILS_ENV=test'
alias -g RES='RAILS_ENV=staging'
