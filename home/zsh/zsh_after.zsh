# stuff oh-my-zsh tries to overwrite...

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export PAGER='less'
export LESS='--ignore-case --RAW-CONTROL-CHARS --LONG-PROMPT'
export LESSOPEN="| src-hilite-lesspipe.sh %s"

# unalias z
# z() {
#   if [[ -z "$*" ]]; then
#     cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
#   else
#     _last_z_args="$@"
#     _z "$@"
#   fi
# }

# zz() {
#   cd "$(_z -l 2>&1 | sed -n 's/^[0-9,.]* *//' | fzf -q $_last_z_args)"
# }

