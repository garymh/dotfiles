#!/usr/local/bin/bash

function new_mr() {
    # cd "$GITLAB_HOME" || exit
    gldb-update
    git fetch origin
    local branch
    url="$1"
    branch=$(glab mr view $(echo $url | grep -oE '[0-9]+$') --repo $(echo $url | sed -E 's|https://[^/]+/([^/]+/[^/]+).*|\1|') --output json | jq -r '.source_branch')
    git checkout -b "$branch" "${2:-origin}/$branch"
}

alias stack="glab stack"

function okimdone() {
    branch=$(git branch --show-current)
    git clean -fd
    git checkout .
    git checkout "$(git-origin-head)"
    git delete-local-branch "$branch"
}

function glreview() {
    url="$(get_git_url "$1")"
    branch="$(get_branch "$1")"
    project="$(get_project "$1")"

    if [[ $url == "git@gitlab.com:gitlab-org/gitlab.git" ]] || [[ $url == "git@gitlab.com:gitlab-org/gitlab-development-kit.git" ]]; then
        e_header "canon"
        git fetch origin
        git checkout -b "$project-review-$branch" "origin/$branch"
    else
        e_header "fork"
        git fetch "$url" "$branch"
        get fetch "${2:-origin/$(git-origin-head)}"
        git checkout -b "$project-review-$branch" FETCH_HEAD
    fi

    git reset --mixed "$(git merge-base "${2:-origin/$(git-origin-head)}" HEAD)"
}

glverify() {
    urlToMR=$1
    cd "$GITLAB_HOME" && pwd && curl "$urlToMR.diff" | git apply
}

function pipeline-fails() {
    glab mr view | awk '/url:/ {print $2}' | xargs gitlab-spec-failures
}

alias mglab='make -C ~/code/work/cli && $HOME/code/work/cli/bin/glab'

alias gdkdev='$HOME/code/work/devkit/gem/bin/gdk'

alias gmc="glab mr checkout"

alias gdks="gdk start"
alias gdkr='gdk restart'
alias gdkst='gdk status'
alias gdkt='gdk tail'

alias gdkthin="gdk stop rails-web && GITLAB_RAILS_RACK_TIMEOUT_ENABLE_LOGGING=false PUMA_SINGLE_MODE=true gdk rails s"
alias sgdkthin="GITLAB_RAILS_RACK_TIMEOUT_ENABLE_LOGGING=false PUMA_SINGLE_MODE=true gdk rails s"
