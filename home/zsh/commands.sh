#!/usr/local/bin/bash

alias fix_audio='sudo killall coreaudiod'

alias debug_vim="/usr/local/bin/vim -u ~/.vimrc_min"
alias debug_nvim="nvim -u ~/.vimrc_min"
alias debug_vimrc="/usr/local/bin/vim -u ~/.vimrc_min ~/.vimrc_min"
alias debug_nvimrc="nvim -u ~/code/dotfiles/home/min_init.lua ~/code/dotfiles/home/min_init.lua"

alias ezshenv='$VISUAL $HOME_DIR/zshenv'
alias ekar='$VISUAL $HOME_DIR/karabiner.json'
alias ealias='$VISUAL $HOME_DIR/zsh/commands.sh'
alias efunction='$VISUAL $HOME_DIR/zsh/commands.sh'
alias egems='$VISUAL $DOTFILES/new_machine/gems'
alias eprivate='$VISUAL $DOTFILES/home/zsh/private/private.zsh'
alias etmux='$VISUAL $DOTFILES/home/tmux.conf'
alias evim='$VISUAL $HOME_DIR/init.lua'
alias egit='$VISUAL $HOME_DIR/gitconfig'
alias zshrc='$VISUAL $HOME_DIR/zshrc'
alias ekitty='$VISUAL $HOME_DIR/kitty/kitty.conf'
alias ealacritty='$VISUAL $DOTFILES/home/alacritty/alacritty.yml'

alias lh=LEFTHOOK=0
alias oc=lh

# alias grbn="git rebase -i HEAD~$1"
alias branch="git branch --show-current"
alias bu="bundle update"
alias combine="git combine-commits"
alias gac="git add -A && git commit -avm"
alias gam='git commit --amend -C HEAD' # Commit current staged files and amend it to the previous commit message without changing the commit or being prompted
alias gc="git add -A && git commit -av"
alias gcaa="git add --all && git commit --amend --no-edit"
alias gcb="git create-branch -r"
alias gcm='git checkout $GITLAB_MAIN_BRANCH'
alias gd="git ksdiff"
alias gdb="git branch --merged | egrep -v \"(^\*|master|develop|dev|staging|production)\" | xargs git branch -d" # Delete all local branches that have been merged into HEAD
alias gdkup='gdk update && gdk reconfigure && be rake db:migrate && git checkout $HOME/code/work/gdk/gitlab/db/structure.sql'
alias gfo="git fetch origin"
alias gin="gem install"
alias gli="gem list"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gnope="git checkout . "
alias gp="git push"
alias gpm="git push -u origin -o merge_request.create -o merge_request.remove_source_branch -o merge_request.label='backend'" # Push the current branch and create a merge request for it
alias gpn="git push -o ci.skip"
alias grb="git rebase"
alias grbi="git rebase -i"
alias grbm='git rebase $GITLAB_MAIN_BRANCH'
alias gun="gem uninstall"
alias gundo="git reset --soft HEAD^ "
alias gco='git checkout'
alias gs="git status -sb"

alias file_size="du -sh"

# File Download (from Prezto)
if _exists curl; then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif _exists wget; then
  alias get='wget --continue --progress=bar --timestamping'
fi

# more verbose fileutils
alias cp='cp -v'
alias chmod='chmod -v'
alias chown='chown -v'
alias rename='rename -v'

if _exists trash; then
  alias rm=trash
elif _exists wget; then
  alias rm="rm -i"
fi

alias oo='open .'
alias plistbuddy="/usr/libexec/PlistBuddy"
alias cask="brew install --cask"
alias bin="brew install"
alias cpu="htop"

alias dnd_notes='$VISUAL ~/Documents/Fun/D\&D/dndnotes'

alias eivm="evim"
alias evimrc="evim"
alias ezshrc="zshrc"
alias eenv="ezshenv"
alias zshenv="ezshenv"
alias rdm="rake db:migrate"
alias rdc="rake db:create"
alias rdd="rake db:drop"
alias rr="rake routes"
alias ..="cd .."
alias :q="exit"
alias branches='git branches'
alias co='branch'
alias console="rails console test -s"
alias killruby='killall -9 ruby'
alias new_branch="git checkout -b"
alias please='sudo $SHELL -c "$(fc -ln -1)"'
alias pubkey="more ~/.ssh/id_ed25519.pub | pbcopy | e_success '=> Public key copied to pasteboard.'"
alias ref="src"
alias x+="+x"

if _exists bat; then
  export BAT_CONFIG_PATH="$DOTFILES/home/batconfig"
  alias cat='bat'
fi

if _exists prettyping; then
  alias ping='prettyping --nolegend'
fi

if _exists lsd; then
  alias ls='lsd'
  alias ll='lsd -al'
  alias lsl='lsd *(@)' # only symlinks
  alias lsx='lsd *(*)' # only executables
fi

# typos
alias gca="gac"
alias vim='$VISUAL'
alias rials="rails"
alias :e='$VISUAL'
alias v='$VISUAL'
alias :q='exit'

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
alias -g NUL="> /dev/null 2>&1"
alias -g S='| sort'
alias -g T='| tail'
alias -g F='| fzf'
alias -g HL="--help"
alias -g V="--version"

alias -g RED='RAILS_ENV=development'
alias -g REP='RAILS_ENV=production'
alias -g RET='RAILS_ENV=test'
alias -g RES='RAILS_ENV=staging'

# work!
alias be="bundle exec"
alias grho="git back-to-origin"
alias harness="scripts/security-harness"
alias gpf="git push --force"
alias amend="git commit --amend"
alias ammend="amend"
alias cont="git rebase --continue"
alias zg="fasd_cd -d gitlab"
alias zd="fasd_cd -d dotfiles"
alias zk="fasd_cd -d dev-kit"
alias lg="lazygit"
alias vis="TERM=xterm-256color vis; printf '\033]104\033\\'"
alias gdks="gdk start"
alias bundle-id="mdls -name kMDItemCFBundleIdentifier -r"

alias gdkdev='$HOME/code/work/dev-kit/gem/bin/gdk'

function fix_key_permissions() { # after reinstalling macos
  sudo chmod 600 ~/.ssh/id_ed25519
  sudo chmod 600 ~/.ssh/id_ed25519.pub
}

function diverged_commit() { git log "$GITLAB_MAIN_BRANCH"..$(git abbrev-ref) --oneline | tail -1 | awk '{ print $1 }'; }
function diverged_ref() { git rev-parse $(diverged_commit)^; }
function gch() { git checkout "$(git branch --list --sort=committerdate | fzf | tr -d '[:space:]')"; }
function rubocop_current_commit() { git diff-tree --no-commit-id --name-only -r HEAD --diff-filter AMT | xargs bundle exec rubocop; }
function rubocop_current_tree() { git diff --name-only --diff-filter AMT | xargs bundle exec rubocop; }
function rubocop_current_branch() { git diff --name-only "$GITLAB_MAIN_BRANCH" --diff-filter AMT | xargs bundle exec rubocop; }
function peek() { tmux split-window -p 33 "$VISUAL" "$@" || exit; }
function unquarantine() { xattr -d com.apple.quarantine "$@"; }
function unquarantine_app() { unquarantine "/Applications/$*"; }
function git_mr_changes() { git diff $(diverged_ref) HEAD; }
function git_mr_kchanges() { git ksdiff $(diverged_ref) HEAD; }
function kindlize() {
        local png="$HOME/code/kindle/kindle.png"
        # convert -density 300 $1 -resize 25% -quality 90 -rotate 90 -colorspace Gray -flatten -fuzz 1% -trim +repage $png
        convert -density 300 $1 -flatten -fuzz 1% -trim +repage $png
        convert $png -resize 800x600 -rotate 90 -colorspace Gray $png
        dropbox put $png new.png


        # /usr/local/bin/convert -density 300 "$1" -quality 90 -colorspace Gray "/Users/gary/code/testbed/big.png"
        # trim
        # rotate
        # /usr/local/bin/convert ~/code/testbed/big.png -rotate 90 ~/code/testbed/out.png
# ~/.zsh/bin/dropbox put ~/code/testbed/out.png new.png
}

function glb() {
  local BRANCH
  BRANCH="$(glreview "$1")"
  cd "$HOME/code/work/gdk/gitlab" || exit
  git fetch origin
  new_branch "REVIEW-$BRANCH" "${2:-origin}\/$BRANCH"
  git reset --mixed "$(git merge-base "${2:-origin/$GITLAB_MAIN_BRANCH}" HEAD)"
}

function okimdone() {
  branch=$(git current-branch)
  git back-to-origin
  git checkout "$GITLAB_MAIN_BRANCH"
  git delete-local-branch "$branch"
}

function zsh_stats() {
  fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n20
}

function c() { cd ~/code/"$1" || exit; }
function cw() { cd ~/code/work/"$1" || exit; }

function savepage() { monolith "$1" -o ~/Documents/Reference/"$2"; }

#alias gpu='[[ -z $(git config "branch.$(git symbolic-ref --short HEAD).merge") ]] &&
#           git push -u origin $(git symbolic-ref --short HEAD) ||
#           git push'

function search() {
  e_header "find . -iname \"*$1*\""
  sudo find . -iname "*$1*"
}

#function gclo() {
#  cd ~/code/
#  git clone "$*"
#}

