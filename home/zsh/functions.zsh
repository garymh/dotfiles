function check_ssl_end() {
  openssl s_client -connect $1:443 | openssl x509 -noout -enddate
}

function fix_key_permissions() {
  # after reinstalling macos
  sudo chmod 600 ~/.ssh/id_rsa
  sudo chmod 600 ~/.ssh/id_rsa.pub
}

peek() { tmux split-window -p 33 "$VISUAL" "$@" || exit; }

function zsh_stats() {
  fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}

export IDEA_FILE="$HOME/Documents/ideas.txt"
function idea() {
  if [ -n "$1" ]; then
    echo "$(date +'[%F %X]') $*" >> $IDEA_FILE
    tail -n 1 $IDEA_FILE
  else
    cat $IDEA_FILE
  fi
}

# insert_sudo () { zle beginning-of-line; zle -U "sudo " }
# zle -N insert-sudo insert_sudo
# bindkey "^a" insert-sudo

# zsh-sticky-prefix
local zle_sticked=""

zle-line-init() {
    BUFFER="$zle_sticked$BUFFER"
    zle end-of-line
}
zle -N zle-line-init

function zle-set-sticky {
    zle_sticked="$BUFFER"
    zle -M "Sticky: '$zle_sticked'."
}
zle -N zle-set-sticky
bindkey '^S' zle-set-sticky

function accept-line {
    if [[ -z "$BUFFER" ]] && [[ -n "$zle_sticked" ]]; then
        zle_sticked=""
        echo -n "\nRemoved sticky."
    fi
    zle .accept-line
}
zle -N accept-line
# zsh-sticky

c() { cd ~/code/$1;  }
_c() { _files -W ~/code -/; }
compdef _c c

h() { cd ~/$1;  }
_h() { _files -W ~/ -/; }
compdef _h h

function gac() {
  hub add -A && hub commit -avm "$*"
}

function search() {
  yellow "find . -iname \"*$1*\""
  sudo find . -iname "*$1*"
}

if _macos; then
  function gclo() {
    cd ~/code/
    git clone "$*"
  }

  function localhost() {
    open "http://localhost:${1:-80}"
  }

  function port() {
    lsof -i ":${1:-80}"
  }
fi

# alias last and save
# use `als c NAME` to chop off the last argument (for filenames/patterns)
function make_alias() {
  local aliasfile chop x
  [[ $# == 0 ]] && green "Name your alias" && return
  if [[ $1 == "c" ]]; then
    chop=true
    shift
  fi
  aliasfile=~/.zsh/recorded_aliases.zsh
  touch $aliasfile
  if [[ `cat "$aliasfile" |grep "alias ${1// /}="` != "" ]]; then
    red "Alias ${1// /} already exists"
  else
    x=`fc -l -n -1`
    if [[ $chop == true ]]; then
      yellow "Chopping..."
      x=$(echo $x | rev | cut -d " " -f2- | rev)
    fi
    echo -e "\nalias ${1// /}=\"`echo $x|sed -e 's/ *$//'|sed -e 's/\"/\\\\"/g'`\"" >> $aliasfile && source $aliasfile
    alias $1
  fi
}

function any() {
  emulate -L zsh
  unsetopt KSH_ARRAYS
  if [[ -z "$1" ]] ; then
    red "any - grep for process(es) by keyword" >&2
    red "Usage: any " >&2 ; return 1
  else
    ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
  fi
}

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

path() {
  echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
    sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
    sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
    sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
    sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
    print }"
}
