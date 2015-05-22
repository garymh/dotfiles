function _rails_command () {
if [ -e "bin/rails" ]; then
  bin/rails $@
elif [ -e "script/rails" ]; then
  ruby script/rails $@
elif [ -e "script/server" ]; then
  ruby script/$@
else
  command rails $@
fi
}

function _rake_command () {
if [ -e "bin/rake" ]; then
  bin/rake $@
else
  command rake $@
fi
}

alias rails='_rails_command'
compdef _rails_command=rails

alias rake='_rake_command'
compdef _rake_command=rake

alias devlog='tail -f log/development.log'
alias prodlog='tail -f log/production.log'
alias testlog='tail -f log/test.log'

alias -g RED='RAILS_ENV=development'
alias -g REP='RAILS_ENV=production'
alias -g RET='RAILS_ENV=test'

# Rails aliases
alias rc='rails console'
alias rd='rails destroy'
alias rdb='rails dbconsole'
alias rg='rails generate'
alias rgm='rails generate migration'
alias rp='rails plugin'
alias ru='rails runner'
alias rs='rails server'
alias rsd='rails server --debugger'
