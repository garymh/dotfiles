build_neovim() {
  cd ~/code/neovim
  git pull
  rm -rf build
  make clean
  make CMAKE_BUILD_TYPE=Release
  make install
}

# fzf:
fj() {
  local dir
  dir=$(fasd -Rdl | fzf --no-sort +m) && cd "$dir"
}
cdf() {
  local file
  local dir
  file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}
fh() {
  print -z $(([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
fo() {
  local out file key
  out=$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}
fd() {
  DIR=$(find ${1:-.} -type d 2> /dev/null | fzf) && cd "$DIR"
}
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}
ftags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-80 | fzf --nth=1,2
  ) && $EDITOR $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}
fshow() {
  local out sha q
  while out=$(
      git log --decorate=short --graph --oneline --color=always |
      fzf --ansi --multi --no-sort --reverse --query="$q" --print-query); do
    q=$(head -1 <<< "$out")
    while read sha; do
      [ -n "$sha" ] && git show --color=always $sha | less -R
    done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
  done
}
fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

function _jira_issue_list {
  zle -U $(truncate_git_issues $(list_git_issues $(basename `pwd`) | choose))
}
zle -N _jira_issue_list
bindkey '\ej' _jira_issue_list

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

function ol() {
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
    echo "Turning VPN off"
  else
    vpnon
    echo "Turning VPN on"
  fi
}

gac() {
  hub add -A && hub commit -avm "$*"
}

search() {
  echo "find . -iname \"*$1*\""
  sudo find . -iname "*$1*"
}

# Show contents of directory after cd-ing into it
chpwd() {
  if [[ $IS_MAC -eq 1 ]]; then
    gls -rthG --color=tty
  else
    ls
  fi
}

if [[ $IS_MAC -eq 1 ]]; then
  gclo() {
    cd ~/code/
    git clone "$*"
  }

  la() {
    gls -a --color=always $*
  }

  vm() {
    VAGRANT_CWD=~/vagrant vagrant up
  }

  vmoff() {
    VAGRANT_CWD=~/vagrant vagrant suspend
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
als() {
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

# -------------------------------------------------------------------
# any function from http://onethingwell.org/post/14669173541/any
# search for running processes
# -------------------------------------------------------------------
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

# -------------------------------------------------------------------
# display a neatly formatted path
# -------------------------------------------------------------------
path() {
  echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
    sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
    sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
    sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
    sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
    print }"
}

