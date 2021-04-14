function fix_key_permissions() {
  # after reinstalling macos
  sudo chmod 600 ~/.ssh/id_ed25519
  sudo chmod 600 ~/.ssh/id_ed25519.pub
}

gch() {
        git checkout “$(git branch --list --sort=committerdate | fzf| tr -d ‘[:space:]’)”
}

#gitlab rubocops
rubocop_current_commit() { git diff-tree --no-commit-id --name-only -r HEAD --diff-filter AMT | xargs bundle exec rubocop }
rubocop_current_tree() { git diff --name-only --diff-filter AMT | xargs bundle exec rubocop }
rubocop_current_branch() { git  diff --name-only master --diff-filter AMT | xargs bundle exec rubocop }

peek() { tmux split-window -p 33 "$VISUAL" "$@" || exit; }
unquarantine() { xattr -d com.apple.quarantine /Applications/$@.app }

git_mr_changes() {
  git diff $(git rev-parse $(git log master..$(git rev-parse --abbrev-ref HEAD) --oneline | tail -1 | awk '{ print $1 }')^) HEAD
}
git_mr_kchanges() {
  git ksdiff $(git rev-parse $(git log master..$(git rev-parse --abbrev-ref HEAD) --oneline | tail -1 | awk '{ print $1 }')^) HEAD
}

nv() {
  if [ ! -z "$TMUX" ]; then
    local ids="$(tmux list-panes -a -F '#{pane_current_command} #{window_id} #{pane_id}' | awk '/^nvim / {print $2" "$3; exit}')"
    local window_id="$ids[(w)1]"
    local pane_id="$ids[(w)2]"
    [ ! -z "$pane_id" ] && tmux select-window -t "$window_id" && tmux select-pane -t "$pane_id"
  fi
  nvr -s $@
}

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

function gcaa() { git add --all && git commit --amend --no-edit }
function gnope() { git checkout . }
function gundo() { git reset --soft HEAD^ }
alias gpu='[[ -z $(git config "branch.$(git symbolic-ref --short HEAD).merge") ]] &&
           git push -u origin $(git symbolic-ref --short HEAD) ||
           git push'

function grbn() { git rebase -i HEAD~$1 }
function gac() { git add -A && git commit -avm "$*" }
function gc() { git add -A && git commit -av }
function gpn() { git push -o ci.skip }
function combine() { git combine-commits $1 }
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

# Local:
# https://stackoverflow.com/questions/21151178/shell-script-to-check-if-specified-git-branch-exists
# test if the branch is in the local repository.
# return 1 if the branch exists in the local, or 0 if not.
function is_in_local() {
    local branch=${1}
    local existed_in_local=$(git branch --list ${branch})

    if [[ -z ${existed_in_local} ]]; then
        echo 0
    else
        echo 1
    fi
}
