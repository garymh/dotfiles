function build_neovim() {
  cd ~/code/neovim
  git pull
  rm -rf build
  make clean
  make CMAKE_BUILD_TYPE=Release
  make install
}

function check_ssl_end() {
  openssl s_client -connect $1:443 | openssl x509 -noout -enddate
}

function fix_key_permissions() {
  # after reinstalling macos
  sudo chmod 600 ~/.ssh/id_rsa
  sudo chmod 600 ~/.ssh/id_rsa.pub
}

insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^s" insert-sudo

# function _git_issue_list {
#   zle -U $(truncate_git_issues $(list_git_issues $(basename `pwd`) | choose))
# }
# zle -N _git_issue_list
# bindkey '^;' _git_issue_list

destroy_docker() {
  docker rm $(docker kill $(docker ps -aq))
  docker rm $(docker ps -a -q)
  docker rmi $(docker images -q)
}

fancy-ctrl-z () {
if [[ $#BUFFER -eq 0 ]]; then
  BUFFER="fg"
  zle accept-line
else
  zle push-input
  zle clear-screen
fi
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

c() { cd ~/code/$1;  }
_c() { _files -W ~/code -/; }
compdef _c c

h() { cd ~/$1;  }
_h() { _files -W ~/ -/; }
compdef _h h

function vpn() {
  /usr/bin/env osascript <<-EOF
  tell application "Shimo"
  set title to "NU VPN"
  set status to connected of account title
  set nu_account to account title

  if status = true then
    disconnect account nu_account
  else
    connect account nu_account
  end if
end tell
return
EOF
}

function gac() {
  hub add -A && hub commit -avm "$*"
}

function search() {
  yellow "find . -iname \"*$1*\""
  sudo find . -iname "*$1*"
}

if [[ $IS_MAC -eq 1 ]]; then
  function gclo() {
    cd ~/code/
    git clone "$*"
  }

  function localhost() {
    open "http://localhost:${1:-3000}"
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

path() {
  echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
    sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
    sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
    sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
    sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
    print }"
}
