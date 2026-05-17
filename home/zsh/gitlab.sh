#!/usr/local/bin/bash

function new_mr() {
    gldb-update
    glab mr checkout "$1"
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
    glab mr checkout "$1"
    iocal branch
    branch=$(git branch --show-current)
    git branch -m "review-$branch"
    git reset --mixed "$(git merge-base "origin/$(git-origin-head)" HEAD)"
}

function gpm() {
    git push -u origin -o merge_request.create \
        -o merge_request.remove_source_branch \
        -o merge_request.label='backend' \
        -o merge_request.label='group::code review' \
        -o merge_request.label='section::dev' \
        -o merge_request.label='devops::create'
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
    local dow after_date before_date
    dow=$(date +%w)
    after_date=$(date -v-$((dow + 8))d +%Y-%m-%d)
    before_date=$(date -v-${dow}d +%Y-%m-%d)
    glab api "events?action=approved&after=${after_date}&before=${before_date}&per_page=100" \
    | python3 -c "
import sys, json
for e in json.load(sys.stdin):
    title = e['target_title']
    if 'a backend maintainer' in title.lower() or 'as backend maintainer' in title.lower():
        continue
    url = f'https://gitlab.com/-/project/{e[\"project_id\"]}/merge_requests/{e[\"target_iid\"]}'
    print(f'- [{title}]({url})')"
}

function my-merges() {
    local dow after_date before_date
    dow=$(date +%w)
    after_date=$(date -v-$((dow + 8))d +%Y-%m-%d)
    before_date=$(date -v-${dow}d +%Y-%m-%d)
    glab api "merge_requests?scope=created_by_me&state=merged&per_page=100" \
    | python3 -c "
import sys, json
from datetime import datetime, timezone, date
start = date.fromisoformat('${after_date}')
end = date.fromisoformat('${before_date}')
for e in json.load(sys.stdin):
    merged = datetime.fromisoformat(e['merged_at'].replace('Z', '+00:00')).date()
    if start < merged < end:
        title = e['title']
        url = e['web_url']
        print(f'- [{title}]({url})')"
}

function my-active() {
    glab api "merge_requests?scope=created_by_me&state=opened&per_page=100" \
    | python3 -c "
import sys, json
in_review, other = [], []
for e in json.load(sys.stdin):
    if e['web_url'].startswith('https://gitlab.com/garyh/'):
        continue
    reviewers = [r for r in e['reviewers'] if r['username'] != 'GitLabDuo']
    title = e['title']
    url = e['web_url']
    prefix = 'Draft: ' if e['draft'] else ''
    line = f'- {prefix}[{title}]({url})'
    if reviewers and not e['draft']:
        in_review.append(line)
    else:
        other.append(line)
if other:
    print('## In progress')
    print('\n'.join(other))
if in_review:
    if other:
        print()
    print('## In review')
    print('\n'.join(in_review))"
}

copy-hooks() {
    cp ~/code/gldb/post-checkout ~/code/work/gdk/gitlab/.git/hooks/post-checkout
    cp ~/code/gldb/post-checkout ~/code/work/cli/.git/hooks/post-checkout
}

