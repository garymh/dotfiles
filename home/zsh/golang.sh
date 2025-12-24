#!/usr/local/bin/bash

alias branches='git branches'
alias grho="git back-to-origin"
alias gpf="git push --force"
alias gpfs="git push security --force"
alias amend="git commit --amend"
alias ammend="amend"
alias cont="git rebase --continue"
alias lg="lazygit"

function diverged_commit() {
  git merge-base "$(main_branch)" "$(git rev-parse --abbrev-ref HEAD)"
}
function main_branch() {
  git remote show origin | sed -n '/HEAD branch/s/.*: //p'
}
# # function diverged_commit() { git log $(main_branch)..$(git abbrev-ref) --oneline | tail -1 | awk '{ print $1 }'; }
# # function diverged_ref() { git rev-parse $(diverged_commit)^; }
# function git_mr_changes() { git diff $(diverged_commit) HEAD; }
# function git_mr_kchanges() { git ksdiff $(diverged_commit) HEAD; }
# function rebase_mr() { git rebase -i $(diverged_commit); }
# function gch() { git checkout "$(git branch --list --sort=committerdate | fzf | tr -d '[:space:]')"; }
# function rubocop_current_commit() { git diff-tree --no-commit-id --name-only -r HEAD --diff-filter AMT | xargs bundle exec rubocop; }
# function rubocop_current_tree() { git diff --name-only --diff-filter AMT | xargs bundle exec rubocop; }
# function rubocop_current_branch() { git diff --name-only "$GITLAB_MAIN_BRANCH" --diff-filter AMT | xargs bundle exec rubocop; }
