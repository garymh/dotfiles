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
alias gp="gitpush"

alias branch="git branch --show-current"

alias amend="git commit --amend"
alias ammend="amend"
alias co='branch'
alias cont="git rebase --continue"
alias gac="git add -A && git commit -avm"
alias gam='git commit --amend -C HEAD' # commit current staged files and amend it to the previous commit message without changing the commit or being prompted
alias gapply='git apply /tmp/quick.diff'
alias gbr='git branches'
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
alias glg='git log --oneline -20'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gm="git add -A && git commit -av"
alias gnb='git checkout -b'
alias gnope="git checkout . "
alias gpf="git push --force"
alias gpfs="git push security --force"
alias gpn="git push -o ci.skip"
alias grb="git rebase"
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi="git rebase -i"
alias grbn="git rebase -i HEAD~$1"
alias grh='git reset --hard'
alias grho="git back-to-origin"
alias grm='git reset --mixed'
alias gs="git status -sb"
alias gsave='git diff > /tmp/quick.diff && echo "Saved to /tmp/quick.diff"'
alias gsavestaged='git diff --staged > /tmp/quick-staged.diff && echo "Saved to /tmp/quick-staged.diff"'
alias gsh='git show'
alias gst='git stash'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstu='git stash --include-untracked'
alias gundo="git reset --soft HEAD^ "
alias lg="lazygit"
alias unwip="git reset --mixed HEAD~"
alias wip="LEFTHOOK=0 git add -A && LEFTHOOK=0 git commit -avm \"wip\""

function grbm() {
    git fetch origin
    git rebase "origin/$(git origin-head)"
}
