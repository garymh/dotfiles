build_neovim() {
  cd ~/code/neovim
  git pull
  rm -rf build
  make clean
  make CMAKE_BUILD_TYPE=Release
  make install
}

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

function localhost() {
  open "http://localhost:${1:-3000}"
}

function port() {
  lsof -i ":${1:-80}"
}

vpn_status() {
  scutil --nc status "NU VPN" | sed -n 1p | grep -qv Disconnected
}

function vpnon() {
  scutil --nc start "NU VPN" --user $NETID --password $NU_PASS --secret northwesternvpn
}

function vpnoff() {
/usr/bin/env osascript <<-EOF
  tell application "System Events"
          tell current location of network preferences
                  set VPN to service "NU VPN"
                  if exists VPN then disconnect VPN
          end tell
  end tell
  return
EOF
}

vpn() {
  if vpn_status; then
    vpnoff
    red "Turning VPN off"
  else
    vpnon
    green "Turning VPN on"
  fi
}

gac() {
  hub add -A && hub commit -avm "$*"
}

search() {
  yellow "find . -iname \"*$1*\""
  sudo find . -iname "*$1*"
}

# Show contents of directory after cd-ing into it
# chpwd() {
#   if [[ $HAS_GLS -eq 1 ]]; then
#     gls -rthG --color=tty
#   else
#     ls
#   fi
# }

if [[ $IS_MAC -eq 1 ]]; then
  gclo() {
    cd ~/code/
    git clone "$*"
  }

  destroy_vm() {
    cd ~/vagrant
    vagrant destroy -f
    rm -rf vagrant_ansible_inventory_default
    rm -rf provisioning/roles/oracle/files/xe.rsp
    rm -rf provisioning/roles/oracle/files/Disk1
    rm -rf provisioning/roles/oracle/extra/dump/*.log
    rm -rf provisioning/roles/oracle/extra/dump/*_test_dump.dmp
  }
fi

# alias last and save
# use `als c NAME` to chop off the last argument (for filenames/patterns)
make_alias() {
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

any() {
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
