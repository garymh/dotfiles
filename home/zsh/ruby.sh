#!/usr/local/bin/bash

alias gin="gem install"
alias gli="gem list"
alias gun="gem uninstall"

alias rdc="rails db:create"
alias rdd="rails db:drop"
alias rr="rails routes"
alias railsc="rails c"
alias console="rails console test -s"
alias killruby='killall -9 ruby'
alias rubo='rubocop -A'
alias rials="rails"

alias -g RED='RAILS_ENV=development'
alias -g REP='RAILS_ENV=production'
alias -g RET='RAILS_ENV=test'
alias -g RES='RAILS_ENV=staging'

alias be="bundle exec"
alias bu="bundle update"

alias ber='bundle exec rspec'
alias berf='bundle exec rspec --fail-fast'

rspec() {
  if [[ $# -eq 0 ]]; then
    local file
    file=$(fd -e rb --full-path '_spec\.rb$|_test\.rb$' |
      fzf --preview 'bat --color=always --line-range :80 {}' \
        --preview-window 'right,60%' \
        --border-label '🧪 Pick a spec to run')
    [[ -n "$file" ]] && bundle exec rspec "$file"
  else
    bundle exec rspec "$@"
  fi
}

test-changes() {
  bundle exec rspec "$(git diff --name-only "$@" | grep -e '_spec.rb$')"
}

cop() {
  bundle exec rubocop "$(git diff --name-only "$@" | grep -e '.rb$')"
}

berchanged() {
  local specs
  specs=$(git diff --name-only "origin/$(git-origin-head)" | grep '_spec.rb$')
  if [[ -n "$specs" ]]; then
    bundle exec rspec $=specs
  else
    echo "No changed spec files found"
  fi
}

berdiff() {
  local specs
  specs=$(git diff --name-only | grep '_spec.rb$')
  if [[ -n "$specs" ]]; then
    bundle exec rspec --fail-fast $=specs
  else
    echo "No changed spec files found"
  fi
}

alias railsg='bundle exec rails generate'
alias railsm='bundle exec rails g migration'
