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

c() { cd ~/code/$1;  }
cw() { cd ~/code/work/$1;  }
h() { cd ~/$1;  }

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
function savepage() { monolith $1 -o ~/Documents/Reference/$2 }

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
