alias fix_audio='sudo killall coreaudiod'
alias disk_space="ncdu --color dark -rr -x --exclude .git --exclude node_modules"

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
alias etmux="$VISUAL $DOTFILES/home/tmux.conf"
alias evim="$VISUAL $HOME_DIR/vimrc"
alias egit="$VISUAL $HOME_DIR/gitconfig"
alias zshrc="$VISUAL $HOME_DIR/zshrc"
alias ekitty="$VISUAL $HOME_DIR/kitty/kitty.conf"
alias g="git"
alias lh=LEFTHOOK=0
alias oc=lh

alias kd="kitty +kitten diff"

alias gam='git commit --amend -C HEAD' # Commit current staged files and amend it to the previous commit message without changing the commit or being prompted
alias gdb="git branch --merged | egrep -v \"(^\*|master|develop|dev|staging|production)\" | xargs git branch -d" # Delete all local branches that have been merged into HEAD
alias gpm="git push -u origin -o merge_request.create -o merge_request.remove_source_branch -o merge_request.label='backend'" # Push the current branch and create a merge request for it
alias gfo="git fetch origin"
alias branch="git branch --show-current"

alias gdkup="gdk update && gdk reconfigure && be rake db:migrate && git checkout $HOME/code/work/gdk/gitlab/db/structure.sql"

alias file_size="du -sh"


# File Download (from Prezto)
if _exists curl; then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif _exists wget; then
  alias get='wget --continue --progress=bar --timestamping'
fi

if _exists trash; then
  alias rm=trash
elif _exists wget; then
  alias rm="rm -i"
fi

alias netwtf='sudo /usr/local/sbin/mtr -n 8.8.8.8'
alias oo='open .'
alias plistbuddy="/usr/libexec/PlistBuddy"
alias cask="brew cask"
alias bin="brew install"
alias cpu="gotop -c monokai -f"

alias dnd_notes="$VISUAL ~/Documents/Fun/D\&D/dndnotes"

alias eivm="evim"
alias evimrc="evim"
alias ezshrc="zshrc"
alias eenv="ezshenv"
alias zshenv="ezshenv"
alias gcb="git create-branch -r"
alias gd="git ksdiff"
alias gin="gem install"
alias gun="gem uninstall"
alias gli="gem list"
alias rdm="rake db:migrate"
alias rdc="rake db:create"
alias rdd="rake db:drop"
alias rr="rake routes"
alias ..="cd .."
alias :q="exit"
alias branches='git branches'
alias co='branch'
alias console="rails console test -s"
alias gco='git checkout'
alias gs="git status -sb"
alias killruby='killall -9 ruby'
alias new_branch="git checkout -b"
alias please='sudo $SHELL -c "$(fc -ln -1)"'
alias pubkey="more ~/.ssh/id_ed25519.pub | pbcopy | e_success '=> Public key copied to pasteboard.'"
alias rails_log="tail -f log/$(echo ${RAILS_ENV:-development} | tr '[:upper:]' '[:lower:]').log"
alias ref="src"
alias spaces2underscores='for i in *; do mv -iv "$i" "${i// /_}"; done'
alias stage_deploy="cap staging deploy"
alias ungit="find . -name '.git' -exec rm -rf {} \;"
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
alias vim="$VISUAL"
alias rials="rails"

alias v="$VISUAL"
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
alias -g HL="--help"
alias -g V="--version"


alias -g RED='RAILS_ENV=development'
alias -g REP='RAILS_ENV=production'
alias -g RET='RAILS_ENV=test'
alias -g RES='RAILS_ENV=staging'

# work!
alias be="bundle exec"
alias grho="git back-to-origin"
alias gcm="git checkout master"
alias grbm="git rebase master"
alias grbi="git rebase -i"
alias grb="git rebase"
alias gp="git push"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias harness="scripts/security-harness"
alias gpf="git push --force"
alias amend="git commit --amend"
alias ammend="amend"
alias cont="git rebase --continue"
alias zg="fasd_cd -d gitlab"
alias zd="fasd_cd -d dotfiles"
alias lg="lazygit"
alias vis="TERM=xterm-256color vis; printf '\033]104\033\\'"
alias gdks="gdk start"
