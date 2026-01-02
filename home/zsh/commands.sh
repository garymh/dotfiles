#!/usr/local/bin/bash

# git.sh

# golang.sh

# gitlab.sh

# overload.sh

alias debug_nvim="NVIM_APPNAME=rawnvim nvim"
alias debug_nvimrc='NVIM_APPNAME=rawnvim nvim $HOME/code/dotfiles/home/vim/min_init.lua'

alias ezshenv='$VISUAL $DOTFILES/home/zprofile'
alias ekar='$VISUAL $DOTFILES/home/karabiner.json'
alias ealias='$VISUAL $DOTFILES/home/zsh/commands.sh'
alias efunction='$VISUAL $DOTFILES/home/zsh/commands.sh'
alias egems='$VISUAL $DOTFILES/new_machine/gems'
alias eprivate='$VISUAL $DOTFILES/home/zsh/private/private.zsh'
alias etmux='$VISUAL $DOTFILES/home/tmux.conf'
alias evimrc='$VISUAL $DOTFILES/home/vim/init.lua'
alias egit='$VISUAL $DOTFILES/home/gitconfig'
alias zshrc='$VISUAL $DOTFILES/home/zshrc'
alias ekitty='$VISUAL $DOTFILES/home/kitty/kitty.conf'
alias ewez='$VISUAL $HOME/.config/wezterm/wezterm.lua'
alias eghost='$VISUAL $HOME/.config/ghostty/config'
alias ealacritty='$VISUAL $DOTFILES/home/alacritty/alacritty.yml'
alias egoku='$VISUAL $HOME/.config/karabiner.edn'

citest() {
  gotestsum --jsonfile test-output.log --no-summary=skipped --junitfile ./coverage.xml --format short -- -coverprofile=./coverage.txt -covermode=atomic ./pkg/... ./internal/... ./commands/... ./cmd/...
}

alias folder-sizes="du -sh * | sort -hr | head"
alias file_size="du -sh"

alias copy-msg='git log --format=%B -n 1 | pbcopy'
alias copy-branch='git rev-parse --abbrev-ref HEAD | pbcopy'

# File Download (from Prezto)
if _exists curl; then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif _exists wget; then
  alias get='wget --continue --progress=bar --timestamping'
fi

alias oo='open .'
alias plistbuddy="/usr/libexec/PlistBuddy"
alias cask="brew install --cask"
alias bin="brew install"

alias ezshrc="zshrc"
alias ezpro="ezshenv"
alias eenv="ezshenv"
alias zshenv="ezshenv"
alias rdm="gdk rake gitlab-db-migrate"
alias rdc="rails db:create"
alias rdd="rails db:drop"
alias rr="rails routes"
alias railsc="rails c"
alias co='branch'
alias console="rails console test -s"
alias killruby='killall -9 ruby'
alias please='sudo $SHELL -c "$(fc -ln -1)"'
alias pubkey="more ~/.ssh/id_ed25519.pub | pbcopy | e_success 'Public key copied to pasteboard.'"
alias ref="exec zsh"
alias path='sed "s/:/\n/g" <<< \"$PATH\"'

# typos
alias cfd="cdf"
alias gca="gac"
alias vim='$VISUAL'
alias rials="rails"
alias :e='$VISUAL'
alias v='$VISUAL'
alias x+="+x"
alias :q="exit"

# zsh global aliases for piping
# alias -g .....='../../../..'
# alias -g ....='../../..'
# alias -g ...='../..'
alias -g C='| tr -d "\n" | pbcopy'
alias -g CA="2>&1 | cat -A"
alias -g G='| grep'
alias -g L="| less"
alias -g LL="2>&1 | less"
alias -g NUL="> /dev/null 2>&1"
alias -g NE="2> /dev/null"
alias -g S='| sort'
alias -g T='| tail'
alias -g F='| fzf'
alias -g H="--help"
alias -g V="--version"
alias -g btail="| bat --paging=never -l log"

alias -g RED='RAILS_ENV=development'
alias -g REP='RAILS_ENV=production'
alias -g RET='RAILS_ENV=test'
alias -g RES='RAILS_ENV=staging'

# work!
function super_bundle() {
  gemfile=$BUNDLE_GEMFILE

  if [ -z "$gemfile" ]; then
    gemfile=$(command bundle config gemfile --parseable | sed -e 's/^gemfile=//')
  fi

  if [ -r "$gemfile" ] && [ -r Gemfile ] &&
    [ "$gemfile" != Gemfile ] &&
    [[ $1 =~ ^(install|update)$ ]]; then
    BUNDLE_GEMFILE=Gemfile command bundle "$@"
    cp Gemfile.lock "${gemfile}.lock"
  fi

  command bundle "$@"
}

logcmd() {
  echo "$*" | tee >(cat) | zsh
}

alias -g DUO="logcmd"

# alias bundle="super_bundle"
alias be="bundle exec"
alias bu="bundle update"
alias harness="scripts/security-harness"

alias zg='cd $GITLAB_HOME'
alias zc='cd $CLI_HOME'
alias zdl='cd "$HOME/Downloads/Personal Folder/Downloads/"'
alias zd="z dotfiles"
alias zk="z devkit"
alias zh="cd ~"

alias bundle-id="mdls -name kMDItemCFBundleIdentifier -r"

function fix_key_permissions() { # after reinstalling macos
  chmod 600 ~/.ssh/id_ed25519
  chmod 600 ~/.ssh/id_ed25519.pub
}

test-changes() {
  bundle exec rspec "$(git diff --name-only "$@" | grep -e '_spec.rb$')"
}

cop() {
  bundle exec rubocop "$(git diff --name-only '$@' | grep -e '.rb$')"
}

function unquarantine() { xattr -d com.apple.quarantine "$@"; }
function unquarantine_app() { unquarantine "/Applications/$*"; }

# e_header()  { echo -e "\n\033[1m$@\033[0m"; }
# e_success() { echo -e " \033[1;32m✔\033[0m  $@"; }
# e_error()   { echo -e " \033[1;31m✖\033[0m  $@"; }
# e_missing()   { e_error "\"brew install $1\" when you get a minute" }

function gotest() {
  go test -json -v "${1:-./...}" 2>&1 | tee /tmp/gotest.log | gotestfmt
}

function h() { cd ~/"$1" || exit; }
function c() { cd ~/code/"$1" || exit; }
function cw() { cd ~/code/work/"$1" || exit; }

function search() {
  e_header "find . -iname \"*$1*\""
  sudo find . -iname "*$1*"
}

function update-withexeditor() {
  npm install -g withexeditorhost &&
    (cd "$(npm -g root)/withexeditorhost" && npm run setup)
}

function update-spotify() {
  spicetify update && spicetify apply
}
