function fix_key_permissions() {
  # after reinstalling macos
  sudo chmod 600 ~/.ssh/id_rsa
  sudo chmod 600 ~/.ssh/id_rsa.pub
}

#gitlab rubocops
rubocop_current_commit() { git diff-tree --no-commit-id --name-only -r HEAD --diff-filter AMT | xargs bundle exec rubocop }
rubocop_current_tree() { git diff --name-only --diff-filter AMT | xargs bundle exec rubocop }
rubocop_current_branch() { git  diff --name-only master --diff-filter AMT | xargs bundle exec rubocop }

peek() { tmux split-window -p 33 "$VISUAL" "$@" || exit; }

glb() {
  url=$1
  local BRANCH="$(glreview $url)"
  cd $HOME/code/work/gdk/gitlab
  git fetch origin
  new_branch $BRANCH ${2:-origin}\/$BRANCH
  git reset --mixed $(git merge-base ${2:-origin/master} HEAD)
}

okimdone() {
  branch=$(git current-branch)
  git back-to-origin
  git checkout master
  git delete-local-branch $branch
}

function zsh_stats() {
  fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}

# stolen from https://github.com/statico/dotfiles/blob/master/.zshrc
expand-or-complete-with-dots() {
echo -n "\e[31m......\e[0m"
zle expand-or-complete
zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

self-insert-redir() {
integer l=$#LBUFFER
zle self-insert
(( $l >= $#LBUFFER )) && LBUFFER[-1]=" $LBUFFER[-1]"
}
zle -N self-insert-redir
for op in \| \< \> \& ; do
  bindkey "$op" self-insert-redir
done

# One keystroke to cd ..
bindkey -s '\eu' '\eq^Ucd ..; ls^M'

# Let ^W delete to slashes - zsh-users list, 4 Nov 2005
backward-delete-to-slash() {
  local WORDCHARS=${WORDCHARS//\//}
  zle .backward-delete-word
}
zle -N backward-delete-to-slash
bindkey "^W" backward-delete-to-slash
# end statico thievery

# bindkey "\e\e" fuck-command-line

# zsh-sticky-prefix
local zle_sticked=""

zle-line-init() {
BUFFER="$zle_sticked$BUFFER"
zle end-of-line
}
zle -N zle-line-init

function zle-set-sticky {
  zle_sticked="$BUFFER"
  zle -M "Sticky: '$zle_sticked'."
}
zle -N zle-set-sticky
bindkey '^S' zle-set-sticky

function accept-line {
  if [[ -z "$BUFFER" ]] && [[ -n "$zle_sticked" ]]; then
    zle_sticked=""
    echo -n "\nRemoved sticky."
  fi
  zle .accept-line
}
zle -N accept-line
# zsh-sticky

c() { cd ~/code/$1;  }
_c() { _files -W ~/code -/; }
compdef _c c

cw() { cd ~/code/work/$1;  }
_cw() { _files -W ~/code/work -/; }
compdef _cw cw

h() { cd ~/$1;  }
_h() { _files -W ~/ -/; }
compdef _h h

alias git_command="git"

function gcaa() { git_command add --all && git_command commit --amend --no-edit }
function gnope() { git_command checkout . }
function gundo() { git_command reset --soft HEAD^ }
alias gpu='[[ -z $(git config "branch.$(git symbolic-ref --short HEAD).merge") ]] &&
           git push -u origin $(git symbolic-ref --short HEAD) ||
           git push'

function gac() { git_command add -A && git_command commit -avm "$*" }
function gc() { git_command add -A && git_command commit -av }
function gpn() { git_command push -o ci.skip }
function combine() { git_command combine-commits $1 }

# _git_fuzzy_branch () { local branch=$(git fuzzy branch); git checkout $branch; zle redisplay }
# zle -N _git_fuzzy_branch
# bindkey ^g^g _git_fuzzy_branch

fuzzydiff() { git fuzzy diff }
zle -N fuzzydiff{,}
bindkey ^g^d fuzzydiff

function search() {
  e_header "find . -iname \"*$1*\""
  sudo find . -iname "*$1*"
}

function gclo() {
  cd ~/code/
  git clone "$*"
}

function any() {
  emulate -L zsh
  unsetopt KSH_ARRAYS
  if [[ -z "$1" ]] ; then
    e_error "any - grep for process(es) by keyword" >&2
    e_error "Usage: any " >&2 ; return 1
  else
    ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
  fi
}

fancy-ctrl-z () {
if [[ $#BUFFER -eq 0 ]]; then
  BUFFER="fg"
  zle accept-line -w
else
  zle push-input -w
  zle clear-screen -w
fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

path() {
  echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
    sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
    sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
    sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
    sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
    print }"
  }
