#!/usr/local/bin/bash

# function gitpush() {
#   BRANCH="$(git rev-parse --abbrev-ref HEAD)"
#   if [[ "$BRANCH" == "master" ]]; then
#     erorr_f "YOU'RE ON MASTER, DOOFUS"
#     # exit 1
#   fi
#
#   if git push "$@"; then
#   else
#     terminal-notifier -title "Git Push Failed" -message "Get back to your terminal" -sound default
#   fi
# }

alias branch="git branch --show-current"

# alias gp=gitpush

alias gac="git add -A && git commit -avm"
alias gam='git commit --amend -C HEAD' # Commit current staged files and amend it to the previous commit message without changing the commit or being prompted
alias gc="git add -A && git commit -av"
alias gcaa="git add --all && git commit --amend --no-edit"
alias gcb="git create-branch -r"
alias gd="git difftool"
alias gdb="git branch --merged | egrep -v \"(^\*|master|main)\" | xargs git branch -d" # Delete all local branches that have been merged into HEAD
alias gfo="git remote update"
alias gfs="git remote update"
alias gin="gem install"
alias gli="gem list"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gm="git add -A && git commit -av"
alias gnope="git checkout . "
alias got="git"
alias grbn="git rebase -i HEAD~$1"
alias unwip="git reset --mixed HEAD~"
alias wip="LEFTHOOK=0 git add -A && LEFTHOOK=0 git commit -avm \"wip\""
alias gpm="git push -u origin -o merge_request.create -o merge_request.remove_source_branch -o merge_request.label='backend'" # Push the current branch and create a merge request for it
# alias gpm="git push -u origin -o merge_request.create -o merge_request.remove_source_branch -o merge_request.label='frontend' -o merge_request.label='section::fulfillment' -o merge_request.label='group::utilization'"
# TODO update these with labels
alias gpn="git push -o ci.skip"
alias grb="git rebase"
alias grbi="git rebase -i"
alias gun="gem uninstall"
alias gundo="git reset --soft HEAD^ "
alias gco='git checkout'
alias gs="git status -sb"

alias gp="git push"
alias gpf="git push --force"

copy-hooks() {
  cp ~/code/gldb/post-checkout ~/code/work/gdk/gitlab/.git/hooks/post-checkout
  cp ~/code/gldb/post-checkout ~/code/work/cli/.git/hooks/post-checkout
}

function grbm() {
  git fetch origin
  git rebase "origin/$(git origin-head)"
}
