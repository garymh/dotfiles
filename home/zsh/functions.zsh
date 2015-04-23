# TODO: incorporate mdfind into search?

vimf() {
  FILE=$(fzf) && vim "$FILE"
}

# fh - repeat history
fh() {
  print -z $(([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

alias fvim='vimf'

function ol() {
  open "http://localhost:${1:-3000}"
}
function port() {
  lsof -i ":${1:-80}"
}

fe() {
  local file
  file=$(fzf --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

fd() {
  DIR=$(find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf) && cd "$DIR"
}

fda() {
  DIR=$(find ${1:-.} -type d 2> /dev/null | fzf) && cd "$DIR"
}

vpn_status() {
  scutil --nc status "NU VPN" | sed -n 1p | grep -qv Disconnected
}

function vpnon() {
/usr/bin/env osascript <<-EOF
tell application "System Events"
        tell current location of network preferences
                set VPN to service "NU VPN"
                if exists VPN then connect VPN
                repeat while (current configuration of VPN is not connected)
                    delay 1
                end repeat
        end tell
end tell
EOF
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

# # Show contents of directory after cd-ing into it
# chpwd() {
#   ls -lrthG --color=tty
# }

# batch change extension
chgext() {
  for file in *.$1 ; do mv $file `echo $file | sed "s/\(.*\.\)$1/\1$2/"` ; done
}

if [[ $IS_MAC -eq 1 ]]; then
  function anybar { echo -n $1 | nc -4u -w0 localhost ${2:-1738}; }

  gclo() {
    cd ~/code/
    git clone "$*"
  }

  ls() {
  #   gls --color=always $*
      k --no-vcs --human
  }


  vm() {
    VAGRANT_CWD=~/code/vagrant_and_oracle_vm_setup vagrant up
  }

  vmoff() {
    VAGRANT_CWD=~/code/vagrant_and_oracle_vm_setup vagrant suspend
  }

  destroy_vm() {
    cd ~/code/vagrant_and_oracle_vm_setup
    vagrant destroy -f
    rm -rf vagrant_ansible_inventory_default
    rm -rf provisioning/roles/oracle/files/xe.rsp
    rm -rf provisioning/roles/oracle/files/Disk1
    rm -rf provisioning/roles/oracle/extra/dump/*.log
    rm -rf provisioning/roles/oracle/extra/dump/*_test_dump.dmp
  }

  bid() {
    local shortname location

    # combine all args as regex
    # (and remove ".app" from the end if it exists due to autocomplete)
    shortname=$(echo "${@%%.app}"|sed 's/ /.*/g')
    # if the file is a full match in apps folder, roll with it
    if [ -d "/Applications/$shortname.app" ]; then
      location="/Applications/$shortname.app"
    else # otherwise, start searching
      location=$(mdfind -onlyin /Applications -onlyin ~/Applications -onlyin /Developer/Applications 'kMDItemKind==Application'|awk -F '/' -v re="$shortname" 'tolower($NF) ~ re {print $0}'|head -n1)
    fi
    # No results? Die.
    [[ -z $location || $location = "" ]] && red "$1 not found, I quit" && return
    # Otherwise, find the bundleid using spotlight metadata
    bundleid=$(mdls -name kMDItemCFBundleIdentifier -r "$location")
    # return the result or an error message
    [[ -z $bundleid || $bundleid = "" ]] && red "Error getting bundle ID for \"$@\"" || echo "$location: $bundleid"
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

