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

alias gdkc='gdk console'
alias gdkd='gdk doctor'
alias gdkdc='gdk doctor --correct'
alias gdkk='gdk stop'
alias gdklog='gdk tail rails-web'
alias gdkp='gdk pull'
alias gdkr='gdk restart'
alias gdkrc='gdk reconfigure'
alias gdkrst='gdk reset-data'
alias gdks="gdk start"
alias gdkst='gdk status'
alias gdkt='gdk tail'
alias gdkup='gdk update'

alias gdkthin="gdk stop rails-web && GITLAB_RAILS_RACK_TIMEOUT_ENABLE_LOGGING=false PUMA_SINGLE_MODE=true gdk rails s"
alias sgdkthin="GITLAB_RAILS_RACK_TIMEOUT_ENABLE_LOGGING=false PUMA_SINGLE_MODE=true gdk rails s"

function my-reviews() {
    local days="${1:-7}"
    local after_date
    after_date=$(date -v-${days}d +%Y-%m-%d)
    glab api "events?action=approved&after=${after_date}&per_page=100" \
    | python3 -c "
import sys, json
for e in json.load(sys.stdin):
    title = e['target_title']
    url = f'https://gitlab.com/-/project/{e[\"project_id\"]}/merge_requests/{e[\"target_iid\"]}'
    print(f'- [{title}]({url})')"
}

copy-hooks() {
    cp ~/code/gldb/post-checkout ~/code/work/gdk/gitlab/.git/hooks/post-checkout
    cp ~/code/gldb/post-checkout ~/code/work/cli/.git/hooks/post-checkout
}

