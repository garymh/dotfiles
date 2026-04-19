#!/usr/local/bin/bash

function gitpush() {
    BRANCH="$(git rev-parse --abbrev-ref HEAD)"
    if [[ "$BRANCH" == "master" ]]; then
        e_error "You're on master already"
        return 1
    fi

    if ! git push "$@"; then
        terminal-notifier -title "Git Push Failed" -message "Get back to your terminal" -sound default
    fi
}


alias branch="git branch --show-current"

alias gac="git add -A && git commit -avm"
alias gam='git commit --amend -C HEAD' # commit current staged files and amend it to the previous commit message without changing the commit or being prompted
alias gc="git add -A && git commit -av"
alias gcaa="git add --all && git commit --amend --no-edit"
alias gcb="git create-branch -r"
alias gcl='git clean -fd'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gd="git difftool"
alias gdb="git branch --merged | egrep -v \"(^\*|master|main)\" | xargs git branch -d" # delete all local branches that have been merged into HEAD
alias gfo="git remote update"
alias gfs="git remote update"
alias gin="gem install"
alias gli="gem list"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gm="git add -A && git commit -av"
alias gnope="git checkout . "
alias gp="gitpush"
alias gpf="git push --force"
alias gpn="git push -o ci.skip"
alias grb="git rebase"
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi="git rebase -i"
alias grbn="git rebase -i HEAD~$1"
alias gs="git status -sb"
alias gst='git stash'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstu='git stash --include-untracked'
alias gundo="git reset --soft HEAD^ "

alias unwip="git reset --mixed HEAD~"
alias wip="LEFTHOOK=0 git add -A && LEFTHOOK=0 git commit -avm \"wip\""

alias gun="gem uninstall"

function gpm() {
    git push -u origin -o merge_request.create \
        -o merge_request.remove_source_branch \
        -o merge_request.label='backend' \
        -o merge_request.label='group::code review' \
        -o merge_request.label='section::dev' \
        -o merge_request.label='devops::create'
}


function grbm() {
    git fetch origin
    git rebase "origin/$(git origin-head)"
}
